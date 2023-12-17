//
//  CreateThreadView.swift
//  ThreadsPro
//
//  Created by Sultan on 16/12/23.
//

import SwiftUI

struct CreateThreadView: View {
    private var user: User? {
        UserService.shared.currentUser
    }

    @StateObject var viewModel = CreatThreadViewModel()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            VStack {
                HStack(alignment: .top) {
                    CircularProfileImage(imageUrl: user?.profileImageUrl, size: .small)

                    VStack(alignment: .leading, spacing: 4) {
                        Text(user?.userName ?? "user_name")
                            .fontWeight(.semibold)

                        TextField("Start a thread...", text: $viewModel.caption, axis: .vertical)
                    }
                    .font(.footnote)

                    Spacer()

                    if !viewModel.caption.isEmpty {
                        Button {
                            viewModel.caption = ""
                        } label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 12, height: 12)
                                .foregroundColor(.gray)
                        }
                    }
                }

                Spacer()
            }
            .navigationTitle("New Thread")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .font(.subheadline)
                    .foregroundColor(.black)
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Post") {
                        Task {
                            try await viewModel.uploadThread()
                            dismiss()
                        }
                    }
                    .opacity(viewModel.caption.isEmpty ? 0.5 : 1.0)
                    .disabled(viewModel.caption.isEmpty)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                }
            }
            .padding()
        }
    }
}

#Preview {
    CreateThreadView()
}
