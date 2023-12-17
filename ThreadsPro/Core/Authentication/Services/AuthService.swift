//
//  AuthService.swift
//  ThreadsPro
//
//  Created by Sultan on 17/12/23.
//

import Firebase
import FirebaseFirestoreSwift
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
            try await UserService.shared.fetchCurrentUser()
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
            try await self.uploadUserData(withEmail: email, fullName: fullName, userName: userName, id: result.user.uid)
        } catch {
            print("DEBUG: Failed to create \(error.localizedDescription)")
        }
    }

    public func signOut() {
        try? Auth.auth().signOut()
        self.userSession = nil
        UserService.shared.reset()
    }

    @MainActor
    private func uploadUserData(
        withEmail email: String,
        fullName: String,
        userName: String,
        id: String
    ) async throws {
        let user = User(id: id, fullName: fullName, email: email, userName: userName)
        guard let userData = try? Firestore.Encoder().encode(user) else { return }
        try await Firestore.firestore().collection("users").document(id).setData(userData)
        UserService.shared.currentUser = user
    }
}
