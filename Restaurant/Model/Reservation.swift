//
//  Reservation.swift
//  Restaurant
//
//  Created by Yafets Mac on 25/11/18.
//  Copyright © 2018 AppsFoundation. All rights reserved.
//

import Foundation

class Reservation {
    var id: Int = -1
    var userId: Int = 0
    var jumlahOrang: Int = 0
    var tempat: String = ""
    var confirmed: Int = 0
    
    init(id: Int, userId: Int, jumlahOrang: Int, tempat: String, confirmed: Int) {
        self.id = id
        self.userId = userId
        self.jumlahOrang = jumlahOrang
        self.tempat = tempat
        self.confirmed = confirmed
    }
    
    func convert(id: Int, userId: String, jumlahOrang: String, tempat: String, confirmed: String) -> Reservation {
        self.id = id
        let usertest = Int(userId) ?? 0
        self.userId = usertest
        self.jumlahOrang = Int(jumlahOrang) ?? 0
        self.tempat = tempat
        self.confirmed = Int(confirmed) ?? 0
        return self
    }
    
}
