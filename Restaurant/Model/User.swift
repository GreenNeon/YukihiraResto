//
//  User.swift
//  Restaurant
//
//  Created by lab_pk_28 on 19/11/18.
//  Copyright © 2018 AppsFoundation. All rights reserved.
//

import Foundation

class User {
    var nama: String
    var email: String
    var foto_url: String
    
    init(nama: String, email: String) {
        self.nama = nama
        self.email = email
        self.foto_url = ""
    }
    init(nama: String, email: String, foto_url: String) {
        self.nama = nama
        self.email = email
        self.foto_url = foto_url
    }
}
