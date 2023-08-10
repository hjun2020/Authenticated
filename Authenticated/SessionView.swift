//
//  SessionView.swift
//  Authenticated
//
//  Created by Kyle Lee on 7/21/20.
//

import SwiftUI
import Amplify

struct SessionView: View {
    @EnvironmentObject var sessionManager: SessionManager

    let user: AuthUser
    
    
    let imageKey: String = "house-icon"

    


    var body: some View {
        
        VStack {
            Spacer()
            Text("You signed in as \(user.username) using Amplify!! 🥳")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            Spacer()
            Button("upload", action: uploadImage)
            Button("Sign Out", action: sessionManager.signOut)
        }
    }
    
    func uploadImage() {
        let houseImage = UIImage(systemName: "house")!
        let housdImageData = houseImage.jpegData(compressionQuality: 1)!
        
        Amplify.Storage.uploadData(key: imageKey, data: housdImageData) { result in
            switch result {
            case .success(let uploadedData):
                print(uploadedData)
            case .failure(let error):
                print(error)
            }
        }
    }
}

struct SessionView_Previews: PreviewProvider {
    private struct DummyUser: AuthUser {
        let userId: String = "1"
        let username: String = "dummy"
    }
    
    static var previews: some View {
        SessionView(user: DummyUser())
    }
}
