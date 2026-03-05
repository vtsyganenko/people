//
//  ContentView.swift
//  PeopleV2
//
//  Created by Виталий Цыганенко on 04.03.2026.
//

import SwiftUI

struct ContentView: View {
    
    @State private var data: [Person] = []
    
    // flag for switching screens
    @State private var showAddPersonView = false
    
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
    ContentView()
}
