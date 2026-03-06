//
//  PeopleV3App.swift
//  PeopleV3
//
//  Created by Виталий Цыганенко on 06.03.2026.
//

import SwiftUI
import SwiftData

@main
struct PeopleV3App: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(for: Person.self)
    }
}
