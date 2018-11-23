//
//  User.swift
//  Restaurant
//
//  Created by lab_pk_30 on 23/11/18.
//  Copyright © 2018 AppsFoundation. All rights reserved.
//

import Foundation

class User {
    var name: String = ""
    var email: String = ""
    var password: String = ""
    var phone: String = ""
    
    init(name: String, email: String, password: String, phone: String) {
        self.name = name
        self.email = email
        self.password = password
        self.phone = phone
    }
}
