//
//  Reservation.swift
//  Restaurant
//
//  Created by Yafets Mac on 25/11/18.
//  Copyright © 2018 AppsFoundation. All rights reserved.
//

import Foundation

class Reservation {
    var id: Int
    var userId: Int
    var jumlahOrang: Int
    var tempat: String
    var confirmed: Int
    
    init(id: Int, userId: Int, jumlahOrang: Int, tempat: String, confirmed: Int) {
        self.id = id
        self.userId = userId
        self.jumlahOrang = jumlahOrang
        self.tempat = tempat
        self.confirmed = confirmed
    }
}
