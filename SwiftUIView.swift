import SwiftUI

struct SwiftUiView: View {
    @State private var currentTime = ""
    @State private var isWifiConnected = true
    @State private var batteryLevel = 80
    var body: some View {
        NavigationView {
            ZStack {
                Color.blue.opacity(0.3).ignoresSafeArea()
                VStack {
                    HStack {
                        Text(currentTime)
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundColor(.black)
                            .padding(.leading, 33)
                        
                        Spacer()
                        Image(systemName: isWifiConnected ? "wifi" : "wifi.slash")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.black)
                        
                        
                        HStack {
                            Image(systemName: "battery.100")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.black)
                            
                            Text("\(batteryLevel)%")
                                .foregroundColor(.black)
                                .font(.system(size: 16, weight: .bold, design: .rounded))
                        }
                        .padding(.trailing, 32)
                    }
                    .padding(.top, 0)
                    .frame(maxWidth: .infinity)
                    .background(Color.clear)
                    .edgesIgnoringSafeArea(.top)
                    .offset(y: 0)
                    
                    Spacer()
                }
                
                HangingBoard()
                    .position(x: UIScreen.main.bounds.width / 2, y: 50)
                
                StaticCloud().position(x: 80, y: 120)
                StaticCloud().position(x: 250, y: 180)
                StaticCloud().position(x: 180, y: 300)
                StaticCloud().position(x: 320, y: 400)
                StaticCloud().position(x: 100, y: 500)
                
                
                NavigationLink(destination: WordGameView()) {
                    StartButton()
                }
                .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
                
                
                GeometryReader { geometry in
                    CurvedGroundView()
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.55)
                        .position(x: geometry.size.width / 2, y: geometry.size.height)
                }
            }
            .onAppear {
               
                updateTime()
            }
        }
    }
    
    
    func updateTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        let timeString = formatter.string(from: Date())
        self.currentTime = timeString
        
      
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            updateTime()
        }
    }
}


struct StaticCloud: View {
    var body: some View {
        Image(systemName: "cloud.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 60)
            .foregroundColor(.white)
            .opacity(0.8)
    }
}


struct HangingBoard: View {
    var body: some View {
        ZStack {
            
            Rectangle()
                .fill(Color.brown)
                .frame(width: 6, height: 190)
                .offset(x: -70, y: -40)
            Rectangle()
                .fill(Color.brown)
                .frame(width: 6, height: 190)
                .offset(x: 70, y: -40)

            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(red: 101 / 255, green: 67 / 255, blue: 33 / 255))
                .frame(width: 260, height: 120)
                .shadow(radius: 5)

            Text("VOCIFYX")
                .font(.system(size: 50, weight: .bold, design: .rounded))
                .foregroundColor(.black)
                .overlay(
                    Text("VOCIFYX")
                        .font(.system(size: 50, weight: .bold, design: .rounded))
                        .foregroundColor(.white.opacity(1.3))
                        .offset(x: 2, y: 2)
                )
        }
        .offset(y: 20)
    }
}


struct CurvedGroundView: View {
    var body: some View {
        GeometryReader { geometry in
            Ellipse()
                .fill(Color.green.opacity(0.9))
                .frame(width: geometry.size.width * 1.2, height: geometry.size.height * 0.55)
                .offset(y: geometry.size.height * 0.2)
                .shadow(radius: 10)
        }
    }
}


struct StartButton: View {
    var body: some View {
        Text("START")
            .font(.system(size: 28, weight: .bold, design: .rounded))
            .foregroundColor(.white)
            .padding()
            .frame(width: 200, height: 60)
            .background(Color.red.opacity(0.9))
            .cornerRadius(15)
            .shadow(radius: 5)
    }
}
struct SwiftUiView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUiView()
    }
}
