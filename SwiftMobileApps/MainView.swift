//
//  MainView.swift
//  SwiftMobileApps
//
//  Created by Ishaan A Patel on 11/13/24.
//

import SwiftUI

struct MainView: View {
    
    @State private var users = [UserModel]()
    @State private var errorMessage = ""
    @State private var showLoginView = false
    @State private var showUpdateUserView = false
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome to the mainscreen")
                
                if errorMessage.isEmpty {
                    Text(errorMessage).foregroundColor(.red)
                }
                
                List(users) { user in
                    VStack(alignment: .leading) {
                        Text("Name: \(user.firstName) \(user.lastName)")
                        Text("City: \(user.city)")
                        Text("Email: \(user.email)")
                    }
                }
                .onAppear {
                    Task {
                        await fetchUsers()
                    }
                }
                
                HStack {
                    Button("Update User") {
                        showUpdateUserView = true
                    }
                    .padding()
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(10)
                    
                    Button("Logout") {
                        Task {
                            await logout()
                        }
                    }
                    .padding()
                    .background(Color.red.opacity(0.2))
                    .cornerRadius(10)
                }
                .padding()
                .navigationDestination(isPresented: $showLoginView) {
                    ContentView()
                }
                .navigationDestination(isPresented: $showUpdateUserView) {
                    UpdateView()
                }
            }
            .navigationBarTitle("User Details")
        }
    }
    
    func fetchUsers() async {
        do {
            users = try await SupabaseManager.shared.fetchUserData()
        } catch {
            errorMessage = "Error fetching users: \(error.localizedDescription)"
        }
    }
    
    func logout() async {
        do {
            try await SupabaseManager.shared.signOut()
            showLoginView = true
        } catch {
            errorMessage = "Error signing out: \(error.localizedDescription)"
        }
    }
}

#Preview {
    MainView()
}
