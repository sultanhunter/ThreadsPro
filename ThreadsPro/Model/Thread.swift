//
//  Thread.swift
//  ThreadsPro
//
//  Created by Sultan on 17/12/23.
//

import Firebase
import FirebaseFirestoreSwift

struct Thread: Identifiable, Codable {
    @DocumentID var threadId: String?
    var id: String {
        return threadId ?? NSUUID().uuidString
    }

    let ownerUid: String
    let caption: String
    let timeStamp: Timestamp
    var likes: Int

    var user: User?
}
