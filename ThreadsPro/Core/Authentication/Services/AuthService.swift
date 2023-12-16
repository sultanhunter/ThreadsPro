//
//  AuthService.swift
//  ThreadsPro
//
//  Created by Sultan on 17/12/23.
//

import Firebase
import Foundation

final class AuthService {
    @Published var userSession: FirebaseAuth.User?

    public static let shared = AuthService()

    private init() {
        self.userSession = Auth.auth().currentUser
    }

    @MainActor
    public func login(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            print("DEBUG: USER LoggedIn: \(result.user.uid)")
        } catch {
            print("DEBUG: Failed to create \(error.localizedDescription)")
        }
    }

    @MainActor
    public func createUser(withEmail email: String, password: String, fullName: String, userName: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            print("DEBUG: USER Created: \(result.user.uid)")
        } catch {
            print("DEBUG: Failed to create \(error.localizedDescription)")
        }
    }

    public func signOut() {
        try? Auth.auth().signOut()
        self.userSession = nil
        print("DEBUG: User signed out")
    }
}
