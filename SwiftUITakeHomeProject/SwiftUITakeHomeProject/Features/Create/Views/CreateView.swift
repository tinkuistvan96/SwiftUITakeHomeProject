//
//  CreateView.swift
//  SwiftUITakeHomeProject
//
//  Created by Tinku István on 2022. 09. 19..
//

import SwiftUI

struct CreateView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var vm = CreateViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                
                firstNameTextField
                lastNameTextField
                jobTextField
                
                Section {
                    submit
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    done
                }
            }
            .navigationTitle("Create")
            .onChange(of: vm.state) { newState in
                if newState == .successfull {
                    dismiss()
                }
            }
            .alert(isPresented: $vm.hasError, error: vm.error) { }
            .disabled(vm.state == .submitting)
            .overlay {
                if vm.state == .submitting {
                    ProgressView()
                }
            }
        }
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}

extension CreateView {
    var done: some View {
        Button("Done") {
            dismiss()
        }
    }
    
    var submit: some View {
        Button("Submit") {
            vm.create()
        }
    }
    
    var firstNameTextField: some View {
        TextField("First Name", text: $vm.newPeople.firstName)
    }
    
    var lastNameTextField: some View {
        TextField("First Name", text: $vm.newPeople.lastName)
    }
    
    var jobTextField: some View {
        TextField("Job", text: $vm.newPeople.job)
    }
}
