//
//  ThreadsTabView.swift
//  ThreadsPro
//
//  Created by Sultan on 16/12/23.
//

import SwiftUI

struct ThreadsTabView: View {
    @State private var selectedTabIndex = 0

    @State private var showCreateThread = false

    init(selectedTabIndex: Int = 0, showCreateThread: Bool = false) {
        self.selectedTabIndex = selectedTabIndex
        self.showCreateThread = showCreateThread
        Task {
            try await UserService.shared.fetchCurrentUser()
        }
    }

    var body: some View {
        TabView(selection: $selectedTabIndex) {
            FeedView()
                .tabItem {
                    Image(systemName: selectedTabIndex == 0 ? "house.fill" : "house")
                        .environment(\.symbolVariants, selectedTabIndex == 0 ? .fill : .none)
                }
                .onAppear { selectedTabIndex = 0 }
                .tag(0)

            ExploreView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
                .onAppear { selectedTabIndex = 1 }
                .tag(1)

            Text("")
                .tabItem {
                    Image(systemName: "plus")
                }
                .onAppear { selectedTabIndex = 2
                    showCreateThread = true
                }
                .tag(2)
                .onTapGesture {}

            ActivityView()
                .tabItem {
                    Image(systemName: selectedTabIndex == 3 ? "heart.fill" : "heart")
                        .environment(\.symbolVariants, selectedTabIndex == 3 ? .fill : .none)
                }
                .onAppear { selectedTabIndex = 3 }
                .tag(3)

            CurrentUserProfileView()
                .tabItem {
                    Image(systemName: selectedTabIndex == 4 ? "person.fill" : "person")
                        .environment(\.symbolVariants, selectedTabIndex == 4 ? .fill : .none)
                }
                .onAppear { selectedTabIndex = 4 }
                .tag(4)
        }

        .sheet(isPresented: $showCreateThread, onDismiss: {
            selectedTabIndex = 0
            showCreateThread = false
        }, content: {
            CreateThreadView()
        })
        .tint(.black)
    }
}

#Preview {
    ThreadsTabView()
}
