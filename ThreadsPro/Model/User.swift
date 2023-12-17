//
//  User.swift
//  ThreadsPro
//
//  Created by Sultan on 17/12/23.
//

import Foundation

struct User: Identifiable, Codable, Hashable {
    let id: String
    let fullName: String
    let email: String
    let userName: String
    var profileImageUrl: String?
    var bio: String?
}
