//
//  SignupView.swift
//  SwiftMobileApps
//
//  Created by Ishaan A Patel on 11/13/24.
//

import SwiftUI

struct SignupView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var city = ""
    @State private var errorMessage = ""
    @State private var isSignedUp = false
    
    var body: some View {
        VStack(spacing: 16){
            HStack{
                Image(systemName: "person")
                TextField("First Name", text: $firstName)
            }
            HStack{
                Image(systemName: "person")
                TextField("Last Name", text: $lastName)
            }
            HStack{
                Image(systemName: "mappin.and.ellipse")
                TextField("City", text: $city)
            }
            HStack{
                Image(systemName: "envelope")
                TextField("Email", text: $email)
            }
            HStack{
                Image(systemName: "lock")
                SecureField("Password", text: $password)
            }
            if !errorMessage.isEmpty{
                Text(errorMessage).foregroundColor(.red)
            }
            
            Button("Sign Up"){
                Task{
                    await signup()
                }
            }.disabled(firstName.isEmpty || lastName.isEmpty || city.isEmpty || email.isEmpty || password.isEmpty)
        }
        .padding()
        .sheet(isPresented: $isSignedUp){
            ContentView()
        }
    }
    
    func signup() async{
        do {
            let _ = try await SupabaseManager.shared.signUp(email: email, password: password)
            isSignedUp = true
            if isSignedUp {
                let user = UserModel(firstName: firstName, lastName: lastName, city: city, email: email)
                try await SupabaseManager.shared.createUserData(user: user)
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

#Preview {
    SignupView()
}
