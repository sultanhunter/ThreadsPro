//
//  UserService.swift
//  ThreadsPro
//
//  Created by Sultan on 17/12/23.
//

import Firebase
import FirebaseFirestoreSwift

final class UserService {
    @Published var currentUser: User?

    public static let shared = UserService()

    private init() {
        Task { try await fetchCurrentUser() }
    }

    @MainActor
    public func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        let user = try snapshot.data(as: User.self)
        currentUser = user
    }

    static func fetchAllUsers() async throws -> [User] {
        guard let currentUid = Auth.auth().currentUser?.uid else { return [] }
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
        let users = snapshot.documents.compactMap { try? $0.data(as: User.self) }
        return users.filter { $0.id != currentUid }
    }

    func reset() {
        currentUser = nil
    }

    @MainActor
    func updateUserProfileImage(withImageUrl imageUrl: String) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }

        try await Firestore.firestore().collection("users").document(currentUid).updateData([
            "profileImageUrl": imageUrl
        ])
        currentUser?.profileImageUrl = imageUrl
    }

    public static func fetchUser(withUid uid: String) async throws -> User {
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        return try snapshot.data(as: User.self)
    }
}
