//
//  LoginView.swift
//  SwiftMobileApps
//
//  Created by Ishaan A Patel on 11/13/24.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var isLoggedIn = false
    

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                HStack {
                    Image(systemName: "envelope.fill")
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                }
                HStack {
                    Image(systemName: "lock")
                    SecureField("Password", text: $password)
                }
                if errorMessage.isEmpty {
                    Text(errorMessage).foregroundColor(.red)
                }
                
                Button("Login") {
                    Task {
                        await login()
                    }
                }
                .disabled(email.isEmpty || password.isEmpty)
            }
            .padding()
            .navigationBarTitle("Login")
            .navigationDestination(isPresented: $isLoggedIn) {
                MainView()
            }
        }
    }
    func login() async {
        do {
            let _ = try await SupabaseManager.shared.signIn(email: email, password: password)
            isLoggedIn = true
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

#Preview {
    LoginView()
}
