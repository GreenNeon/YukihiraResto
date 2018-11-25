//
//  LeftMenuViewController.swift
//  Restaurant
//
//  Created by AppsFoundation on 8/28/15.
//  Copyright © 2015 AppsFoundation. All rights reserved.
//

import UIKit

enum MenuItemType: Int {
    case OurItem = 0
    case Profile
    case Reservation
    case Logout
}

class LeftMenuViewController: UIViewController {
    
    @IBOutlet weak var menuTableView: UITableView?
    
    static var menuItems: [String] = []
    var menuItemsImages: [String] = []
    static var selectedMenuItemIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)

        LeftMenuViewController.menuItems = ["OUR MENU","LOGIN","RESERVATION","LOG OUT"]
        menuItemsImages = ["our_menu","feedback","reservation","find_us"]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadData(){
        menuTableView?.reloadData()
    }
    
    func logOut() {
        LeftMenuViewController.menuItems[1] = "LOGIN"
        AppDelegate.sharedDelegate().openLogin()
    }
    
}

// MARK: - UITableViewDataSource
extension LeftMenuViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LeftMenuViewController.menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: "menuCell") as! MenuTableViewCell
        
        cell.selectedMenuImageView?.isHidden = LeftMenuViewController.selectedMenuItemIndex != indexPath.row
        cell.itemNameLabel?.text = LeftMenuViewController.menuItems[indexPath.row]
        cell.itemImageView?.image = UIImage(named: menuItemsImages[indexPath.row])
        
        cell.backgroundColor = UIColor.clear
        return cell
    }
}

// MARK: - UITableViewDelegate
extension LeftMenuViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        LeftMenuViewController.selectedMenuItemIndex = indexPath.row
        
        switch LeftMenuViewController.selectedMenuItemIndex {
        case MenuItemType.OurItem.rawValue:
            AppDelegate.sharedDelegate().openOurMenu()
            break
        case MenuItemType.Profile.rawValue:
            if LeftMenuViewController.menuItems[MenuItemType.Profile.rawValue] == "LOGIN" {
                AppDelegate.sharedDelegate().openLogin()
            } else {
                AppDelegate.sharedDelegate().openProfile()
            }
            break
        case MenuItemType.Reservation.rawValue:
            AppDelegate.sharedDelegate().openReservation()
            break
        case MenuItemType.Logout.rawValue:
            self.logOut()
            break
        default:
            break
        }
        
        menuTableView?.reloadData()
    }
}
