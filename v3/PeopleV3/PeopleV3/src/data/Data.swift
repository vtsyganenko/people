//
//  Data.swift
//  PeopleV2
//
//  Created by Виталий Цыганенко on 04.03.2026.
//

import Foundation
import SwiftData

@Model
final class Person {
    var name: String
    var surname: String
    var phone: String
    var birthDate: Date? = nil
    
    var fullName: String {
        get { name + " " + surname }
    }
    
    init(name: String, surname: String, phone: String) {
        self.name = name
        self.surname = surname
        self.phone = phone
    }
}
