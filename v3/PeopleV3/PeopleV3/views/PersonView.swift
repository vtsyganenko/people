//
//  PersonView.swift
//  PeopleV2
//
//  Created by Виталий Цыганенко on 04.03.2026.
//

import SwiftUI

struct PersonView: View {
    
    // "interface"
    @Bindable var person: Person
    
    // PropertyWrapper to close the window
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
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
                LabeledContent("Name", value: person.name)
                LabeledContent("Surname", value: person.surname)
                HStack {
                    Image(systemName: "phone.circle")
                    Spacer()
                    Text(person.phone)
                }
            }
        }
        .navigationTitle("aaa")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .bottomBar, content: {
                Button("Закрыть") { dismiss() }
            })
        }
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
