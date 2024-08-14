import SwiftUI
import Amplify

struct ContentView: View {
    @State private var isSignedIn = false
    @State private var username = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            if isSignedIn {
                Text("Hello, \(username)!")
                Button("Sign Out") {
                    signOut()
                }
            } else {
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button("Sign In") {
                    signIn()
                }
            }
        }
        .padding()
    }
    
    func signIn() {
        Task {
            do {
                let signInResult = try await Amplify.Auth.signIn(username: username, password: password)
                if signInResult.isSignedIn {
                    DispatchQueue.main.async {
                        self.isSignedIn = true
                    }
                }
            } catch {
                print("Sign in failed: \(error)")
            }
        }
    }
    
    func signOut() {
        Task {
            do {
                _ = try await Amplify.Auth.signOut()
                DispatchQueue.main.async {
                    self.isSignedIn = false
                    self.username = ""
                    self.password = ""
                }
            } catch {
                print("Sign out failed: \(error)")
            }
        }
    }
}

#Preview {
    ContentView()
}
