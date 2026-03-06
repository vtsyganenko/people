//
//  ContentView.swift
//  PeopleV2
//
//  Created by Виталий Цыганенко on 04.03.2026.
//

import SwiftUI
import SwiftData

struct MainView: View {
    
    // SwiftData context
    @Environment(\.modelContext) private var modelContext
    
    // list received by query
    @Query(sort: \Person.name) private var persons: [Person]
    
    @State private var selectedPerson: Person?
    
    // flags for switching screens
    @State private var showAddPersonView = false
    @State private var showPersonView = false
    
    var body: some View {
        NavigationStack {
            ListView
                .navigationTitle("People")
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        HStack {
                            Button(action: {
                                print("")
                            }, label: {
                                Image(systemName: "gear")
                            })
                            .font(.title)
                            
                            Spacer()
                            
                            Button(action: {
                                clearAll()
                            }, label: {
                                Image(systemName: "pencil")
                            })
                            .font(.title)
                            
                            Spacer()
                            
                            Button(action: {
                                addElement()
                            }, label: {
                                Image(systemName: "plus.circle")
                            })
                            .font(.title)
                        }
                    }
                }
                .sheet(isPresented: $showAddPersonView, content: {
                    AddPersonView { newPerson in
                        // save to SwiftData
                        modelContext.insert(newPerson)
                    }
                })
                .sheet(item: $selectedPerson) { person in
                    // just pass object to @Bindable
                    PersonView(person: person)
                }
        }
    }
    
    @ViewBuilder
    private var ListView: some View {
        if persons.isEmpty {
            Text("List will be here...")
        } else {
            List {
                ForEach(persons) { person in
                    Text(person.fullName)
                        // use whole width
                        .frame(maxWidth: .infinity, alignment: .leading)
                        // make whole area clickable
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedPerson = person
                        }
                }
            }
            .listStyle(.plain)
        }
    }
    
    func addElement() {
        showAddPersonView = true
    }
    
    func clearAll() {
        for person in persons {
            modelContext.delete(person)
        }
    }
}

#Preview {
    MainView()
        // Preview can use SwiftData, but all data will be stored in RAM only
        .modelContainer(for: Person.self, inMemory: true)
}
