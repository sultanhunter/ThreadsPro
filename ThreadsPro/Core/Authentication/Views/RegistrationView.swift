//
//  RegistrationView.swift
//  ThreadsPro
//
//  Created by Sultan on 16/12/23.
//

import SwiftUI

struct RegistrationView: View {
    @StateObject var viewModel = RegistrationViewModel()

    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            Spacer()

            Image("threads-app-icon")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .padding(.bottom, 16)

            TextField("Enter your email", text: $viewModel.email)
                .autocapitalization(.none)
                .modifier(ThreadsTextFieldModifier())

            SecureField("Enter your password", text: $viewModel.password)
                .autocapitalization(.none)
                .modifier(ThreadsTextFieldModifier())

            TextField("Enter your full name", text: $viewModel.fullName)
                .autocapitalization(.none)
                .modifier(ThreadsTextFieldModifier())

            TextField("Enter your username", text: $viewModel.userName)
                .autocapitalization(.none)
                .modifier(ThreadsTextFieldModifier())

            Button {
                Task {
                    try await viewModel.createUser()
                }
            } label: {
                Text("Sign Up")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 352, height: 44)
                    .background(.black)
                    .cornerRadius(8)
            }
            .padding(.vertical)

            Spacer()

            Divider()

            Button {
                dismiss()
            } label: {
                HStack(spacing: 3) {
                    Text("Already have an account?")
                    Text("Sign In")
                        .fontWeight(.semibold)
                }
                .foregroundColor(.black)
                .font(.footnote)
            }
            .padding(.vertical, 16)
        }
    }
}

#Preview {
    RegistrationView()
}
