import SwiftUI

struct WordGameView: View {
    @State private var usedWords = [String]()
    @State private var incorrectWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var allWords = predefinedWords
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    @State private var score = 0
    @State private var highscore = UserDefaults.standard.integer(forKey: "Highscore")
    @State private var showHint = false
    @State private var showBrownBucket = false
    
    // State to show instructions
    @State private var showInstructions = false
    
    var body: some View {
        ZStack {
            Color.blue.opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        showInstructions.toggle()
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .font(.title)
                            .foregroundColor(.black) // Icon color black
                    }
                    .padding()
                }
                
                Text("VocifyX")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .foregroundColor(.black)
                    .padding(.top, 40)
                
                Text("  \(rootWord)  ")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.yellow)
                    .cornerRadius(10)
                    .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
                    .padding(.vertical)
                
                Text("Score: \(score)")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                TextField("Enter your word", text: $newWord)
                    .padding()
                    .font(.system(size: 20, weight: .medium, design: .rounded))
                    .foregroundColor(.black)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(15)
                    .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
                    .padding(.horizontal, 20)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .onSubmit(addNewWord)
                
                List {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle.fill")
                                .foregroundColor(.yellow)
                                .shadow(radius: 5)
                            Text(word)
                                .font(.title2)
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color.purple.opacity(0.5))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .transition(.slide)
                        .animation(.spring(), value: usedWords)
                    }
                    .listRowBackground(Color.clear)
                }
                .listStyle(PlainListStyle())
                .background(Color.clear)
                .padding(.horizontal, 20)
                
                HStack {
                    Button(action: { showHint.toggle() }) {
                        HStack {
                            Image(systemName: "lightbulb.fill")
                                .foregroundColor(.yellow)
                            Text("Hint")
                        }
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .foregroundColor(.black)
                    }
                    
                    Button("Check incorrect ones") {
                        showBrownBucket = true
                    }
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10)
                    .foregroundColor(.black)
                    
                    Button("Restart") {
                        restartGame()
                    }
                    .padding()
                    .background(Color.red.opacity(0.8))
                    .cornerRadius(10)
                    .foregroundColor(.white)
                }
                
                if showHint {
                    Text("💡 Try to think of the words that are related to \(rootWord)!")
                        .foregroundColor(.white)
                        .font(.title3)
                        .padding(.top)
                }
                
                Text("High Score: \(highscore)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 20)
            }
        }
        .onAppear {
            loadWords()
        }
        .alert(errorTitle, isPresented: $showingError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage)
        }
        .sheet(isPresented: $showBrownBucket) {
            BrownBucketView(incorrectWords: $incorrectWords)
        }
        .sheet(isPresented: $showInstructions) {
            InstructionsView(showInstructions: $showInstructions)
        }
    }
    
    // Instructions View
    struct InstructionsView: View {
        @Binding var showInstructions: Bool
        
        var body: some View {
            NavigationView {
                VStack {
                    Text("Game Instructions")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top)
                    
                    Text("1. The game will show a root word.\n2. You need to enter words that can be formed from the root word.\n3. Try to form as many words as possible.\n4. Your score is based on the length of each word you enter.\n5. Use hints if needed!")
                        .font(.body)
                        .padding()
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Button("Got it!") {
                        // Dismiss the instructions sheet
                        showInstructions = false
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .navigationTitle("Instructions")
                .navigationBarTitleDisplayMode(.inline)
                .background(Color.white.edgesIgnoringSafeArea(.all))
            }
        }
    }
    
    func loadWords() {
        DispatchQueue.global(qos: .userInitiated).async {
            let wordCount = predefinedWords.count
            print("Loading \(wordCount) words...")
            DispatchQueue.main.async {
                self.allWords = predefinedWords
                startGame()
            }
        }
    }

    func restartGame() {
        // Reset the game state
        usedWords.removeAll()
        incorrectWords.removeAll()
        score = 0
        rootWord = allWords.randomElement() ?? "example"
        newWord = ""
    }

    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else { return }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original!")
            return
        }
        
        guard isPossible(word: answer) else {
            // Store incorrect word in Brown Bucket
            incorrectWords.append(answer)
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }
        
        guard isReal(word: answer) else {
            // Store incorrect word in Brown Bucket
            incorrectWords.append(answer)
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        
        score += answer.count
        if score > highscore {
            highscore = score
            UserDefaults.standard.set(highscore, forKey: "Highscore")
        }
        
        newWord = ""
    }
    
    func startGame() {
        rootWord = allWords.randomElement() ?? "example"
        usedWords.removeAll()
        score = 0
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct BrownBucketView: View {
    @Binding var incorrectWords: [String]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(incorrectWords, id: \.self) { word in
                    Text(word)
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(8)
                }
            }
            .navigationTitle("Incorrect Words")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.black.edgesIgnoringSafeArea(.all))
        }
    }
}

#Preview {
    WordGameView()
}
