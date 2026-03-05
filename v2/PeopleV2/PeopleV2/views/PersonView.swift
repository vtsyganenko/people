//
//  PersonView.swift
//  PeopleV2
//
//  Created by Виталий Цыганенко on 04.03.2026.
//

import SwiftUI

struct PersonView: View {
    
    let name: String
    
    var body: some View {
        VStack {
            Image(systemName: "person.circle")
                .font(.system(size: 100))
            Text("Это экран для: \(name)")
                .font(.title)
        }
        .navigationTitle(name)
        // Чтобы заголовок не был огромным на втором экране
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
    
}
