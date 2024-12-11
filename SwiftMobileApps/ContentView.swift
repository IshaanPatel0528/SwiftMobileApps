//
//  ContentView.swift
//  SwiftMobileApps
//
//  Created by Ishaan A Patel on 11/13/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                NavigationLink(destination: SignupView()) {
                    HStack {
                        Image(systemName: "person.crop.circle.badge.plus")
                            .imageScale(.large)
                            .foregroundStyle(.tint)
                        Text("Sign Up")
                    }
                }
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(10)
                
                NavigationLink(destination: LoginView()) {
                    HStack {
                        Image(systemName: "person.crop.circle.badge.minus")
                            .imageScale(.large)
                            .foregroundStyle(.tint)
                        Text("Log In")
                    }
                }
                .padding()
                .background(Color.green.opacity(0.1))
                .cornerRadius(10)
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
