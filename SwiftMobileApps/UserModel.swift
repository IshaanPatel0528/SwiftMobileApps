//
//  UserModel.swift
//  SwiftMobileApps
//
//  Created by Ishaan A Patel on 11/13/24.
//

import Foundation

struct UserModel: Identifiable, Codable {
    
    var id: String?
    var firstName: String
    var lastName: String
    var city: String
    var email: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case firstName = "firstname"
        case lastName = "lastname"
        case city = "city"
        case email = "email"
    }
}
