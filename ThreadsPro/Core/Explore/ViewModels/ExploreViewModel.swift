//
//  ExploreViewModel.swift
//  ThreadsPro
//
//  Created by Sultan on 17/12/23.
//

import Foundation

final class ExploreViewModel: ObservableObject {
    @Published var allUsers = [User]()

    init() {
        Task { [weak self] in
            try await self?.fetchUsers()
        }
    }

    @MainActor
    private func fetchUsers() async throws {
        self.allUsers = try await UserService.fetchAllUsers()
    }
}
