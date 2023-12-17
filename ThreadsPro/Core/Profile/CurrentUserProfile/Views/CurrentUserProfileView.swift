//
//  CurrentUserProfile.swift
//  ThreadsPro
//
//  Created by Sultan on 17/12/23.
//

import SwiftUI

struct CurrentUserProfileView: View {
    @StateObject var viewModel = CurrentUserProfileViewModel()
    @State private var showEditProfile = false

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                // bio and stats
                VStack(spacing: 20) {
                    ProfileHeaderView(user: viewModel.currentUser)

                    Button {
                        showEditProfile.toggle()
                    } label: {
                        Text("Edit Profile")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .frame(width: 352, height: 32)
                            .background(.white)
                            .cornerRadius(8)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(.systemGray4), lineWidth: 1)
                            }
                    }
                    if viewModel.currentUser != nil {
                        UserContentListView(user: viewModel.currentUser!)
                    }
                }
            }
            .sheet(isPresented: $showEditProfile, content: {
                if let user = viewModel.currentUser {
                    EditProfileView(user: user)
                }

            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        AuthService.shared.signOut()
                    } label: {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .foregroundColor(.black)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    CurrentUserProfileView()
}
