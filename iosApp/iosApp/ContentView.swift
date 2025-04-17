import SwiftUI
import shared

struct ContentView: View {
    
    var body: some View {
        ZStack {
            // Unity View
            UnityView()
                .edgesIgnoringSafeArea(.all) // Ensures Unity view covers the entire screen
                .zIndex(0) // Explicitly set UnityView's zIndex to 0

            // Button at the bottom of the screen
            VStack {
                Spacer() // Pushes the button to the bottom
                
                Button("Rotate Cube") {
                    print("Button tapped!")
                    UnitySendMessage("Cube", "RotateFromNative", "")
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(12)
                .padding(.bottom, 50) // Add bottom padding to ensure it's above the screen edge
                .shadow(radius: 10) // Optional: add a shadow for better visibility
            }
            .zIndex(1) // Ensures the button is on top of Unity view
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
