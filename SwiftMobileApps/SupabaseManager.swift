//
//  SupabaseManager.swift
//  SwiftMobileApps
//
//  Created by Ishaan A Patel on 11/13/24.
//

import Foundation
import Supabase

class SupabaseManager {
    static let shared = SupabaseManager()
    private let client: SupabaseClient
    
    private init() {
        let url = URL(string: "https://ikdntbrckydncsgjvkdu.supabase.co")!
        let key = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlrZG50YnJja3lkbmNzZ2p2a2R1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjQwNzEzNzEsImV4cCI6MjAzOTY0NzM3MX0._Xu0E7kvUheliPbfLXiO9uQ_CWVDE3_scGhgXdFOAVM"
        client = SupabaseClient(supabaseURL: url, supabaseKey: key)
    }
    
    func getSession() async throws -> User? {
        do {
            let session = try await client.auth.session
            print("Authenticated User:", session.user)
            return session.user
        } catch {
            print("Failed to retrieve session:", error.localizedDescription)
            throw error
        }
    }
    
    func signUp(email: String, password: String) async throws -> Void {
        do {
            let user = try await client.auth.signUp(email: email, password: password)
            print("User signed up:", user)
        } catch {
            print("sign up failed:", error.localizedDescription)
            throw error
        }
    }
    
    func createUserData(user: UserModel) async throws {
        do {
            let _ = try await client.from("table_1").insert([
                "firstname": user.firstName,
                "lastname": user.lastName,
                "city": user.city,
                "email": user.email
            ]).execute()
        }
    }
    
    func signIn(email: String, password: String) async throws -> User {
        do {
            let session = try await client.auth.signIn(email: email, password: password)
            print("User signed in:", session.accessToken)
            return session.user
        } catch {
            print("Sign in failed:", error.localizedDescription)
            throw error
        }
    }
    
    func fetchUserData() async throws -> [UserModel] {
        guard let user = try await getSession() else {
            throw NSError(domain: "SupabaseManager", code: 401, userInfo: [NSLocalizedDescriptionKey: "No user session"])
        }
        print("fetching user ID:", user.id)
        
        
        do {
            let response = try await client.from("table_1").select().eq("id", value: user.id).execute()
            let users = try JSONDecoder().decode([UserModel].self, from: response.data)
            return users
        } catch {
            print("Failed to fetch user data:", error.localizedDescription)
            throw error
        }
    }
    
    func signOut() async throws {
        do {
            try await client.auth.signOut()
            print("User signed out successfully")
        } catch {
            print("Sign out failed:", error.localizedDescription)
            throw error
        }
    }
    
    func updateUserView(first: String, last: String, city: String) async throws {
        guard let userID = try await getSession()?.id else {
            throw NSError(domain: "SupabaseManager", code: 401, userInfo: [NSLocalizedDescriptionKey: "No session"])
        }
        do {
            let _ = try await client.from("table_1").update([
                "firstname": first,
                "lastname": last,
                "city": city
            ])
            .eq("id", value: userID)
            .execute()
        } catch {
            print("Failed to update user data:", error.localizedDescription)
            throw error
        }
    }
}
