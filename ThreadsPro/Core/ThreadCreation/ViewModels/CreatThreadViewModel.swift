//
//  ThreadCreationViewModel.swift
//  ThreadsPro
//
//  Created by Sultan on 17/12/23.
//

import Firebase

final class CreatThreadViewModel: ObservableObject {
    @Published var caption = ""

    public func uploadThread() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        let thread = Thread(ownerUid: uid, caption: caption, timeStamp: Timestamp(), likes: 0)

        try await ThreadService.uploadThread(thread)
    }
}
