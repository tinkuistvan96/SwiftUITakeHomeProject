//
//  CreateView.swift
//  SwiftUITakeHomeProject
//
//  Created by Tinku István on 2022. 09. 19..
//

import SwiftUI

struct CreateView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var job = ""
    
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
            //Submit form
        }
    }
    
    var firstNameTextField: some View {
        TextField("First Name", text: $firstName)
    }
    
    var lastNameTextField: some View {
        TextField("First Name", text: $lastName)
    }
    
    var jobTextField: some View {
        TextField("Job", text: $job)
    }
}
