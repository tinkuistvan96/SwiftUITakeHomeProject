//
//  DetailView.swift
//  SwiftUITakeHomeProject
//
//  Created by Tinku István on 2022. 09. 19..
//

import SwiftUI

struct DetailView: View {
    @State private var userInfo: UserDetailResponse?
    
    var body: some View {
        ZStack {
            background
            
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    
                    avatar
                    Group {
                        general
                        link
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 18)
                    .background(Theme.detailBackground, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
                .padding()
            }
        }
        .onAppear {
            do {
                userInfo = try StaticJSONMapper.decode(file: "SingleUserData", type: UserDetailResponse.self)
            } catch {
                print(error)
            }
        }
        .navigationTitle("Details")
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previewUser: UserDetailResponse {
        let userInfo = try! StaticJSONMapper.decode(file: "SingleUserData", type: UserDetailResponse.self)
        return userInfo
    }
    
    static var previews: some View {
        NavigationView {
            DetailView()
        }
    }
}

private extension DetailView {
    var background: some View {
        Theme.background
            .ignoresSafeArea(edges: .top)
    }
    
    @ViewBuilder
    var avatar: some View {
        if let avatarAbsoluteString = userInfo?.data.avatar,
           let avatarURL = URL(string: avatarAbsoluteString) {
            AsyncImage(url: avatarURL) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ZStack {
                    Theme.detailBackground
                    ProgressView()
                }
            }
            .frame(height: 250)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
    }
    
    @ViewBuilder
    var link: some View {
        if let supportAbsoluteString = userInfo?.support.url,
           let supportUrl = URL(string: supportAbsoluteString),
           let supportTxt = userInfo?.support.text {
            Link(destination: supportUrl) {
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(supportTxt)
                        .foregroundColor(Theme.text)
                        .font(
                            .system(.body, design: .rounded)
                            .weight(.semibold)
                        )
                        .multilineTextAlignment(.leading)
                    
                    Text(supportAbsoluteString)
                }
                
                Spacer()
                
                Symbols.link
                    .font(
                        .system(.title3, design: .rounded)
                    )
            }
        }
    }
    
    var general: some View {
        VStack(alignment: .leading, spacing: 8) {
            PillView(id: userInfo?.data.id ?? 0)
            Group {
                firstName
                lastName
                email
            }
            .foregroundColor(Theme.text)
        }
    }
    
    @ViewBuilder
    var firstName: some View {
        Text("First Name")
            .font(
                .system(.body, design: .rounded)
                .weight(.semibold)
            )
        
        Text(userInfo?.data.firstName ?? "-")
            .font(
                .system(.subheadline, design: .rounded)
            )
        
        Divider()
    }
    
    @ViewBuilder
    var lastName: some View {
        Text("Last Name")
            .font(
                .system(.headline, design: .rounded)
            )
            .bold()
        
        Text(userInfo?.data.lastName ?? "-")
            .font(
                .system(.subheadline, design: .rounded)
            )
        
        Divider()
    }
    
    @ViewBuilder
    var email: some View {
        Text("Email")
            .font(
                .system(.headline, design: .rounded)
            )
            .bold()
        
        Text(userInfo?.data.email ?? "-")
            .font(
                .system(.subheadline, design: .rounded)
            )
    }
}
