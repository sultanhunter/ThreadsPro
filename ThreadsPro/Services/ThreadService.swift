//
//  ThreadService.swift
//  ThreadsPro
//
//  Created by Sultan on 17/12/23.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation
struct ThreadService {
    public static func uploadThread(_ thread: Thread) async throws {
        guard let threadData = try? Firestore.Encoder().encode(thread) else { return }
        try await Firestore.firestore().collection("threads").addDocument(data: threadData)
    }

    public static func fetchThreads() async throws -> [Thread] {
        let snapshot = try await Firestore
            .firestore()
            .collection("threads")
            .order(by: "timeStamp", descending: true)
            .getDocuments()

        return try snapshot.documents.compactMap {
            try $0.data(as: Thread.self)
        }
    }

    public static func fetchUserThreads(uid: String) async throws -> [Thread] {
        let snapshot = try await Firestore
            .firestore()
            .collection("threads")
            .whereField("ownerUid", isEqualTo: uid)
            .getDocuments()

        return try snapshot.documents.compactMap {
            try $0.data(as: Thread.self)
        }.sorted(by: { $0.timeStamp.dateValue() > $1.timeStamp.dateValue() })
    }
}
