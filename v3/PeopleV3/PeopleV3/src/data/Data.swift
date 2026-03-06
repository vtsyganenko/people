//
//  Data.swift
//  PeopleV2
//
//  Created by Виталий Цыганенко on 04.03.2026.
//

import Foundation

struct Person: Identifiable {
    let id = UUID()
    
    var name: String
    var surname: String
    var phone: String
    
    var fullName: String {
        get { name + " " + surname }
    }
}
