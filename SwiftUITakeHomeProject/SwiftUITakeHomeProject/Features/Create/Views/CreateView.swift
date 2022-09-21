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
    @FocusState private var focusedField: Field?
    let successfulAction: () -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    firstNameTextField
                    lastNameTextField
                    jobTextField
                } footer: {
                    if case .validation(let err) = vm.error,
                       let errorDescription = err.errorDescription {
                        Text(errorDescription)
                            .foregroundStyle(.red)
                    }
                }

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
                    successfulAction()
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
        CreateView { }
    }
}

extension CreateView {
    enum Field: Hashable {
        case firstName, lastName, job
    }
    
    var done: some View {
        Button("Done") {
            dismiss()
        }
    }
    
    var submit: some View {
        Button("Submit") {
            focusedField = nil
            vm.create()
        }
    }
    
    var firstNameTextField: some View {
        TextField("First Name", text: $vm.newPeople.firstName)
            .focused($focusedField, equals: .firstName)
    }
    
    var lastNameTextField: some View {
        TextField("Last Name", text: $vm.newPeople.lastName)
            .focused($focusedField, equals: .lastName)
    }
    
    var jobTextField: some View {
        TextField("Job", text: $vm.newPeople.job)
            .focused($focusedField, equals: .job)
    }
}
