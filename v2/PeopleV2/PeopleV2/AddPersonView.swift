//
//  AddPersonView.swift
//  PeopleV2
//
//  Created by Виталий Цыганенко on 04.03.2026.
//

import SwiftUI

struct AddPersonView: View {
    
    @State private var name = ""
    @State private var surname = ""
    @State private var phone = ""
    
    // output
    var onSuccess: (Person) -> Void
    
    // PropertyWrapper to close the window
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                TextField("Surname", text: $surname)
                TextField("Phone", text: $phone)
                    .keyboardType(.phonePad)
            }
            .navigationTitle("New Person")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Button("Save") {
                            onSuccess(Person(name: name, surname: surname, phone: phone))
                            dismiss()
                        }
                        .font(.title)
                        .disabled(name.isEmpty && surname.isEmpty)
                        Button("Cancel") {
                            dismiss()
                        }
                        .font(.title)
                    }
                }
            }
        }
    }
}

#Preview {
    AddPersonView() { person in }
}
