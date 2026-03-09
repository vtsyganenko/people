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
    
    // "interface" - output callback
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
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .font(.title2)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        let newPerson = Person(name: name, surname: surname, phone: phone)
                        onSuccess(newPerson)
                        dismiss()
                    }
                    .font(.title2)
                    .disabled(name.isEmpty && surname.isEmpty)
                }
            }
        }
    }
}

#Preview {
    // pass empty callback to Preview version
    AddPersonView() { person in }
}
