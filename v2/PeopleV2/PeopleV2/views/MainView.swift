//
//  ContentView.swift
//  PeopleV2
//
//  Created by Виталий Цыганенко on 04.03.2026.
//

import SwiftUI

struct MainView: View {
    
    @State private var data: [Person] = []
    @State private var selectedPerson: Person?
    
    // flag for switching screens
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
                        data.append(newPerson)
                    }
                })
                .sheet(item: $selectedPerson) { person in
                    if let index = data.firstIndex(where: { $0.id == person.id}) {
                        PersonView(person: $data[index])
                    }
                }
        }
    }
    
    @ViewBuilder
    private var ListView: some View {
        if data.isEmpty {
            Text("List will be here...")
        } else {
            List {
                ForEach(data) { person in
                    Text(person.fullName)
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
        data.removeAll()
    }
}

#Preview {
    MainView()
}
