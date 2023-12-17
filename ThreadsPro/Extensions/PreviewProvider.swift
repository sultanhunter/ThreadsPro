//
//  PreviewProvider.swift
//  ThreadsPro
//
//  Created by Sultan on 17/12/23.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.shared
    }
}

final class DeveloperPreview {
    public static let shared = DeveloperPreview()

    let user = User(id: NSUUID().uuidString, fullName: "Max Verstappen", email: "max@gmail.com", userName: "maxverstappen1")
}
