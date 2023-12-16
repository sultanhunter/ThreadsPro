//
//  LoginViewModel.swift
//  ThreadsPro
//
//  Created by Sultan on 17/12/23.
//

import Foundation

final class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""

    @MainActor
    func logIn() async throws {
        try await AuthService.shared.login(withEmail: email, password: password)
    }
}
