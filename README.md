VocifyX - SwiftUI Word Game
VocifyX is a SwiftUI-based mobile game that blends fun with learning by challenging players to form valid words from a root word. The game keeps track of scores, provides hints, and stores incorrect words in a "Brown Bucket." It also features an interactive UI with animated elements like clouds and a hanging board to create an engaging experience. The app aims to encourage cognitive skill development through word formation while offering a visually appealing interface.

Features:
Dynamic Time Display: The app displays the current time at the top, ensuring the user stays updated on the time while playing.
Network and Battery Information: The app displays the current WiFi status and battery percentage, keeping users informed about their device’s status.
Interactive Game UI: Includes a hanging board displaying the game’s title and animated clouds for a lively feel.
Word Formation: Players are presented with a root word and must form as many valid words as possible from it.
Score and Highscore: The game tracks the player's score and displays the highscore, allowing users to compete with themselves.
Hints: Players can ask for a hint, suggesting words related to the root word.
Brown Bucket: Incorrect words are stored in the “Brown Bucket” for review later.
Instructions: Clear instructions on how to play the game are accessible for first-time players.
Responsive Design: The app adapts to various screen sizes and orientations for optimal performance.
App Overview:
The app contains two main screens:

SwiftUiView (Main View):
Displays the current time, WiFi status, and battery level.
Features an animated scene with static clouds and a hanging board displaying the game title "VOCIFYX."
A "START" button leads to the word formation game screen.
WordGameView:
Displays the root word and allows the player to enter words formed from it.
Tracks used and incorrect words, offering error messages for invalid or previously used words.
Features buttons for hints, checking incorrect words, and restarting the game.
Tracks and displays the player’s score, highscore, and offers a leaderboard feature with word difficulty levels.
Technologies Used:
SwiftUI: The app uses SwiftUI for the user interface, providing a declarative framework for building the app’s visual elements.
UIKit: For word validation and text input, UIKit components like UITextChecker are used.
UserDefaults: The highscore is saved in UserDefaults for persistence between sessions.
Installation Instructions:
Clone the repository to your local machine:

bash
Copy
git clone https://github.com/your-username/vocifyx.git
Open the project in Xcode:

bash
Copy
open VocifyX.xcodeproj
Build and run the project in Xcode to see it in action on your simulator or connected device.

How to Play:
Start the Game: Once the app is opened, click the "START" button to begin.
Form Words: The app will present you with a root word. Enter valid words that can be formed using the letters of the root word.
Score Points: Each valid word entered increases your score. The longer the word, the more points you earn.
Use Hints: If you get stuck, click on the “Hint” button for suggestions related to the root word.
Incorrect Words: If you enter an invalid word, it will be stored in the "Brown Bucket," and you will receive a message explaining the error.
Highscore: The app will keep track of your highest score and display it at the top of the screen.
Contributing:
Fork the repository.
Create a new branch (git checkout -b feature-branch).
Make changes and commit them (git commit -am 'Add new feature').
Push to the branch (git push origin feature-branch).
Create a new pull request.
License:
This project is licensed under the MIT License - see the LICENSE file for details.

Acknowledgements:
SwiftUI for providing a modern, declarative framework for building the UI.
Xcode for being the primary IDE for iOS development.
All contributors to the project.
Enjoy playing and improving your vocabulary with VocifyX!
