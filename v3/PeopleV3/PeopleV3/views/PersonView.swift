//
//  PersonView.swift
//  PeopleV2
//
//  Created by Виталий Цыганенко on 04.03.2026.
//

import SwiftUI

struct PersonView: View {
    
    // "interface" - Person object passed to view or edit
    @Bindable var person: Person
    
    // PropertyWrapper to close the window
    @Environment(\.dismiss) private var dismiss
    
    // View/Edit mode flag
    private enum Mode { case view, edit }
    @State private var mode = Mode.view
    
    // Data variables for UI
    @State private var name: String = ""
    @State private var surname: String = ""
    @State private var phone: String = ""
    
    var body: some View {
        NavigationStack {
            PersonInfoView
                .toolbar {
                    if (mode == .view) {
                        ToolbarItem(placement: .topBarTrailing, content: {
                            Button {
                                name = person.name
                                surname = person.surname
                                phone = person.phone
                                mode = .edit
                            } label: {
                                Image(systemName: "pencil")
                            }
                        })
                    }
                    else {
                        ToolbarItem(placement: .topBarLeading, content: {
                            Button {
                                mode = .view
                            } label: {
                                Image(systemName: "xmark")
                            }
                        })
                        ToolbarItem(placement: .topBarTrailing, content: {
                            Button {
                                saveInput()
                            } label: {
                                Image(systemName: "checkmark")
                            }
                        })

                    }
                    ToolbarItem(placement: .bottomBar, content: {
                        Button("Close") { dismiss() }
                    })
                }
        }
    }
    
    @ViewBuilder
    private var PersonInfoView: some View {
        List {
            Section {
                HStack {
                    Spacer()
                    VStack(spacing: 10) {
                        Image(systemName: "person.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.blue)
                        Text(person.fullName)
                            .font(.title.bold())
                    }
                    Spacer()
                }
                .listRowBackground(Color.clear)
            }
            Section(header: Text("Main info")) {
                LabeledContent {
                    if (mode == .view) {
                        Text(person.name)
                    } else {
                        TextField("Enter name", text: $name)
                            .multilineTextAlignment(.trailing)
                            .onSubmit { saveInput() }
                    }
                } label: {
                    Text("Name")
                }
                
                LabeledContent {
                    if (mode == .view) {
                        Text(person.surname)
                    } else {
                        TextField("Enter surname", text: $surname)
                            .multilineTextAlignment(.trailing)
                            .onSubmit { saveInput() }
                    }
                } label: {
                    Text("Surname")
                }
                
                LabeledContent {
                    if (mode == .view) {
                        Text(person.phone)
                    } else {
                        TextField("Enter name", text: $phone)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.phonePad)
                            .onSubmit { saveInput() }
                    }
                } label: {
                    Label("", systemImage: "phone")
                }
                
            }
        }
    }
    
    func saveInput() {
        person.name = name
        person.surname = surname
        person.phone = phone
        mode = .view
    }
    
}

#Preview {
    struct PreviewWrapper : View {
        @State var person = Person(name: "John", surname: "Doe", phone: "123-456-789")
        
        var body: some View {
            PersonView(person: person)
        }
    }
    
    return PreviewWrapper()
}
