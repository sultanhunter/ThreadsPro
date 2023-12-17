//
//  ExploreView.swift
//  ThreadsPro
//
//  Created by Sultan on 16/12/23.
//

import SwiftUI

struct ExploreView: View {
    @State private var searchText = ""
    @StateObject var viewModel = ExploreViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.allUsers) { user in
                        NavigationLink(value: user) {
                            VStack {
                                UserCell(user: user)

                                Divider()
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationDestination(for: User.self, destination: { user in
                ProfileView(user: user)
            })
            .navigationTitle("Search")
            .searchable(text: $searchText, prompt: "Search")
        }
    }
}

#Preview {
    ExploreView()
}
