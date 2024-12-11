//
//  UpdateView.swift
//  SwiftMobileApps
//
//  Created by Ishaan A Patel on 11/22/24.
//

import SwiftUI

struct UpdateView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var city = ""
    @State private var errorMessage = ""
    @State private var isUpdated = false
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Image(systemName: "person")
                TextField("First Name", text: $firstName)
            }
            HStack {
                Image(systemName: "person")
                TextField("Last Name", text: $lastName)
            }
            HStack {
                Image(systemName: "mappin.and.ellipse")
                TextField("City", text: $city)
            }
            if !errorMessage.isEmpty {
                Text(errorMessage).foregroundColor(.red)
            }
            
            Button("Update!!!!!") {
                Task{
                    await updateUser()
                }
            }.disabled(firstName.isEmpty || lastName.isEmpty || city.isEmpty)
        }
        .padding()
        .sheet(isPresented: $isUpdated) {
            MainView()
        }
    }
    
    func updateUser() async {
        do {
            try await SupabaseManager.shared.updateUserView(first: firstName, last: lastName, city: city)
            isUpdated = true
        } catch {
            errorMessage = "Failed to update profile: \(error.localizedDescription)"
        }
    }
}



