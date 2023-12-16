//
//  CircularProfileImage.swift
//  ThreadsPro
//
//  Created by Sultan on 16/12/23.
//

import SwiftUI

struct CircularProfileImage: View {
    var body: some View {
        Image("threads-app-icon")
            .resizable()
            .scaledToFill()
            .frame(width: 40, height: 40)
            .background(Color(.systemCyan))
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    CircularProfileImage()
}
