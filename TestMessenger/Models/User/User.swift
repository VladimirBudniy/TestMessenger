//
//  User.swift
//  TestMessenger
//
//  Created by Vladimir Budniy on 11.06.17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation

struct User {
    var lastName: String?
    var id: String?
    var photo: String?
    var username: String?
    var firstName: String?
        
    static func create(_ lastName: String?,
                _ id: String?,
                _ photo: String?,
                _ username: String?,
                _ firstName: String?) -> User? {
        return User(lastName: lastName, id: id, photo: photo, username: username, firstName: firstName)
    }
    
    static func create(with json: [String: Any]?) -> User? {
        let lastName = json?["last_name"] as? String
        let id = json?["id"] as? String
        let photo = json?["photo"] as? String
        let username = json?["username"] as? String
        let firstName = json?["first_name"] as? String

        return User(lastName: lastName, id: id, photo: photo, username: username, firstName: firstName)
    }
}
