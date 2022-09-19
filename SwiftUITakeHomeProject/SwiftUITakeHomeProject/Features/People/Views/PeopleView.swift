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
                Theme.background
                    .ignoresSafeArea(edges: .top)
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(0...5, id: \.self) { item in
                            VStack(spacing: .zero) {
                                Rectangle()
                                    .fill(.blue)
                                    .frame(height: 130)
                                
                                VStack(alignment: .leading) {
                                    Text("#\(item)")
                                        .font(
                                            .system(.caption, design: .rounded)
                                            .bold()
                                        )
                                        .foregroundColor(.white)
                                        .padding(.vertical, 4)
                                        .padding(.horizontal, 9)
                                        .background(Theme.pill, in: Capsule())
                                    Text("<First Name> <Last Name>")
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
                }
                .padding()
            }
            .navigationBarTitle("People")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        //
                    } label: {
                        Symbols.plus
                            .font(
                                .system(.headline, design: .rounded)
                                .bold()
                            )
                    }

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
