//
//  FeedViewModel.swift
//  ThreadsPro
//
//  Created by Sultan on 17/12/23.
//

import Foundation

class FeedViewModel: ObservableObject {
    @Published var threads: [Thread] = []

    init() {
        Task { try await fetchThreads() }
    }

    @MainActor
    public func fetchThreads() async throws {
        threads = try await ThreadService.fetchThreads()
        try await fetchUserDataForThreads()
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
