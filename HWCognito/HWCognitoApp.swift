import SwiftUI
import Amplify
import AWSCognitoAuthPlugin

@main
struct HWCognitoApp: App {
    init() {
        configureAmplify()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    private func configureAmplify() {
        do {
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            
            let authConfig = AuthCategoryConfiguration(
                plugins: [
                    "awsCognitoAuthPlugin": [
                        "UserAgent": "aws-amplify/cli",
                        "Version": "0.1.0",
                        "CognitoUserPool": [
                            "Default": [
                                "PoolId": "ap-southeast-1_3Y41qeyV3",
                                "AppClientId": "23ug73r81fv6qea3dvo11u6rb1",
                                "Region": "ap-southeast-1"
                            ]
                        ],
                        "Auth": [
                            "Default": [
                                "authenticationFlowType": "USER_SRP_AUTH"
                            ]
                        ]
                    ]
                ]
            )
            
            let amplifyConfig = AmplifyConfiguration(auth: authConfig)
            
            try Amplify.configure(amplifyConfig)
            print("Amplify configured successfully")
        } catch {
            print("Failed to configure Amplify: \(error)")
        }
    }
}
