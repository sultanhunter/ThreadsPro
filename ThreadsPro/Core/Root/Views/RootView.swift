//
//  ContentView.swift
//  ThreadsPro
//
//  Created by Sultan on 16/12/23.
//

import SwiftUI

struct RootView: View {
    @StateObject var viewModel = RootViewModel()

    var body: some View {
        if viewModel.isLoggedIn {
            ThreadsTabView()
        } else {
            LoginView()
        }
    }
}

#Preview {
    RootView()
}
