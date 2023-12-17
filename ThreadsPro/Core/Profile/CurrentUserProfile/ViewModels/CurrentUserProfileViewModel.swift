//
//  ProfileViewModel.swift
//  ThreadsPro
//
//  Created by Sultan on 17/12/23.
//

import Combine
import Foundation
import PhotosUI
import SwiftUI

final class CurrentUserProfileViewModel: ObservableObject {
    @Published var currentUser: User?

    private var cancellable = Set<AnyCancellable>()

    init() {
        setupSubscribers()
    }

    private func setupSubscribers() {
        UserService.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
            print("DEBUG:Fetched User Data \(String(describing: user))")
        }
        .store(in: &cancellable)
    }
}
