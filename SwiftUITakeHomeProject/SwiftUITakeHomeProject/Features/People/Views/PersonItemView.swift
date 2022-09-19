//
//  PersonItemView.swift
//  SwiftUITakeHomeProject
//
//  Created by Tinku István on 2022. 09. 19..
//

import SwiftUI

struct PersonItemView: View {
    let user: User
    
    var body: some View {
        VStack(spacing: .zero) {
            AsyncImage(url: URL(string: user.avatar)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Theme.detailBackground)
            }
            .frame(height: 130)
            
            VStack(alignment: .leading) {
                PillView(id: user.id)
                Text("\(user.firstName) \(user.lastName)")
                    .foregroundColor(Theme.text)
                    .font(
                        .system(.body, design: .rounded)
                    )
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 8)
            .padding(.vertical, 5)
            .background(Theme.detailBackground)
        }
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Theme.text.opacity(0.1), radius: 2, x: 0, y: 1)
    }
}

struct PersonItemView_Previews: PreviewProvider {
    static var previewUser: User {
        let users = try! StaticJSONMapper.decode(file: "UserStaticData", type: UsersResponse.self)
        return users.data.first!
    }
    
    static var previews: some View {
        PersonItemView(user: previewUser)
            .frame(width: 200)
    }
}
