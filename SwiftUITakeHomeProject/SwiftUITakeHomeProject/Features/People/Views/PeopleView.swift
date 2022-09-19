//
//  PeopleView.swift
//  SwiftUITakeHomeProject
//
//  Created by Tinku István on 2022. 09. 19..
//

import SwiftUI

struct PeopleView: View {
    let columns = [
        GridItem(.flexible()), GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                background
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(0...5, id: \.self) { item in
                            PersonItemView(user: item)
                        }
                    }
                }
                .padding()
            }
            .navigationBarTitle("People")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    create
                }
            }
        }
    }
}

struct PeopleView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleView()
    }
}

extension PeopleView {
    var create: some View {
        Button {
            //Create User
        } label: {
            Symbols.plus
                .font(
                    .system(.headline, design: .rounded)
                    .bold()
                )
        }
    }
    
    var background: some View {
        Theme.background
            .ignoresSafeArea(edges: .top)
    }
}
