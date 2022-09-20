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
    
    @StateObject var vm = PeopleViewModel()
    @State private var showCreateView = false
    @State private var showPopover = false
    
    var body: some View {
        NavigationView {
            ZStack {
                background
                
                if vm.isLoading {
                    ProgressView()
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(vm.users, id: \.id) { user in
                                NavigationLink {
                                    DetailView(userId: user.id)
                                } label: {
                                    PersonItemView(user: user)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationBarTitle("People")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    create
                }
            }
            .onAppear {
                vm.fetchUsers()
            }
            .sheet(isPresented: $showCreateView) {
                CreateView {
                    withAnimation(.spring().delay(0.25)) {
                        self.showPopover = true
                    }
                }
            }
            .alert(isPresented: $vm.hasError, error: vm.error) {
                Button("Retry") {
                    vm.fetchUsers()
                }
            }
            .overlay {
                if showPopover {
                    CheckmarkPopoverView()
                        .transition(.scale.combined(with: .opacity))
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                withAnimation(.spring()) {
                                    self.showPopover = false
                                }
                            }
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

extension PeopleView {
    var create: some View {
        Button {
            showCreateView.toggle()
        } label: {
            Symbols.plus
                .font(
                    .system(.headline, design: .rounded)
                    .bold()
                )
        }
        .disabled(vm.isLoading)
    }
    
    var background: some View {
        Theme.background
            .ignoresSafeArea(edges: .top)
    }
}
