//
//  UserContentListViewModel.swift
//  ThreadsPro
//
//  Created by Sultan on 17/12/23.
//

import Foundation

class UserContentListViewModel: ObservableObject {
    let user: User

    init(user: User) {
        self.user = user
        Task {
            try await fetchUserThreads()
            try await fetchUserDataForThreads()
        }
    }

    @Published var threads = [Thread]()

    @MainActor
    public func fetchUserThreads() async throws {
        threads = try await ThreadService.fetchUserThreads(uid: user.id)
    }

    @MainActor
    private func fetchUserDataForThreads() async throws {
        for i in 0 ..< threads.count {
            let thread = threads[i]
            let ownerUid = thread.ownerUid
            let user = try await UserService.fetchUser(withUid: ownerUid)
            threads[i].user = user
        }
    }
}
