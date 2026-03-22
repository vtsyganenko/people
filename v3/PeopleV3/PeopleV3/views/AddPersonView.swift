//
//  AddPersonView.swift
//  PeopleV2
//
//  Created by Виталий Цыганенко on 04.03.2026.
//

import SwiftUI
import PhotosUI

struct AddPersonView: View {
    
    @State private var name = ""
    @State private var surname = ""
    @State private var phone = ""
    
    @State private var birthDate: Date = Date()
    @State private var applyBirthDate = false
    
    @State private var selectedPhotoItem: PhotosPickerItem? = nil
    @State private var selectedPhotoData: Data? = nil
    @State private var selectedPhotoImage: UIImage? = nil
    
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
                
                if !applyBirthDate {
                    Text("Birthday")
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .contentShape(Rectangle())
                        .foregroundStyle(.tertiary)
                        .onTapGesture {
                            applyBirthDate = true
                        }
                } else {
                    HStack {
                        DatePicker("Birthdate", selection: $birthDate, in: ...Date(), displayedComponents: .date)
                        Image(systemName: "trash")
                            .font(.title)
                            .foregroundStyle(Color.black)
                            .onTapGesture {
                                applyBirthDate = false
                            }
                    }
                }
                
                if (selectedPhotoImage == nil) {
                    PhotosPicker(selection: $selectedPhotoItem, matching: .images) {
                        Text("Photo")
                            .foregroundStyle(.tertiary)
                            .foregroundStyle(Color.black)
                    }
                } else {
                    HStack {
                        Text("Photo")
                        Spacer()
                        Image(uiImage: selectedPhotoImage!)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        Spacer()
                        Image(systemName: "trash")
                            .font(.title)
                            .foregroundStyle(Color.black)
                            .onTapGesture {
                                selectedPhotoImage = nil
                                selectedPhotoData = nil
                            }
                    }
                }
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
                        if (applyBirthDate) { newPerson.birthDate = birthDate }
                        newPerson.photoData = selectedPhotoData
                        onSuccess(newPerson)
                        dismiss()
                    }
                    .font(.title2)
                    .disabled(name.isEmpty && surname.isEmpty)
                }
            }
            .onChange(of: selectedPhotoItem) { oldItem, newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                        selectedPhotoData = data
                        selectedPhotoImage = UIImage(data: data)
                        // clear selection in the PhotosPicker
                        selectedPhotoItem = nil
                    }
                }
            }
        }
    }
}

#Preview {
    // pass empty callback to Preview version
    AddPersonView() { person in }
}
