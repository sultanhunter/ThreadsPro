//
//  ProfileHeaderView.swift
//  ThreadsPro
//
//  Created by Sultan on 17/12/23.
//

import SwiftUI

struct ProfileHeaderView: View {
    let user: User?
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 12) {
                // fullname and username
                VStack(alignment: .leading, spacing: 4) {
                    Text(user?.fullName ?? "User")
                        .font(.title2)
                        .fontWeight(.semibold)

                    Text(user?.userName ?? "user_name")
                        .font(.subheadline)
                }
                if let bio = user?.bio {
                    Text(bio)
                        .font(.footnote)
                }

                Text("2 followers")
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Spacer()

            CircularProfileImage(imageUrl: user?.profileImageUrl, size: .medium)
        }
    }
}

// #Preview {
//    ProfileHeaderView()
// }
