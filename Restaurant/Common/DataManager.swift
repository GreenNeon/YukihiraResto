//
//  DataManager.swift
//  Restaurant
//
//  Created by lab_pk_28 on 19/11/18.
//  Copyright © 2018 AppsFoundation. All rights reserved.
//

import Foundation
import SwiftyJSON

class DataManager {
    func MenuAll() -> Array<MenuItem> {
        let MenuData = UserDefaults.standard.array(forKey: "menus")
        let json = JSON(MenuData)
        
    
        let menu1 = MenuItem(name: "Makanan", ingredients: "gula, gula, cindy, shani, melody", image: "photo_item3", price: "$25",discount: nil)
        let array = [menu1]
        return MenuData as? Array<MenuItem> ?? [MenuItem]()
    }
    func SaveMenu() {
        var MenuArray = [MenuItem]()
        let menu1 = MenuItem(name: "Makanan 1", ingredients: "gula, gula, cindy, shani, melody", image: "photo_item3", price: "$25",discount: nil)
        let menu2 = MenuItem(name: "Makanan 2", ingredients: "gula, gula, cindy, shani, melody", image: "photo_item2", price: "$150",discount: nil)
        let menu3 = MenuItem(name: "Makanan 3", ingredients: "gula, gula, cindy, shani, melody", image: "photo_item1", price: "$100",discount: nil)
        
        MenuArray.append(menu1)
        MenuArray.append(menu2)
        MenuArray.append(menu3)
        let placesData = JSON(MenuArray)
        UserDefaults.standard.set(placesData, forKey: "menus")
    }
}
