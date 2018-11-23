//
//  OurMenuViewController.swift
//  Restaurant
//
//  Created by AppsFoundation on 8/28/15.
//  Copyright © 2015 AppsFoundation. All rights reserved.
//

import UIKit

class OurMenuViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView?
    
    var menuItems: [MenuItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuItems = []
        DataManager().DoFetchMakanan() { responseObject, error in
            // use responseObject and error here
            self.menuItems = responseObject!
            self.tableView!.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - UITableViewDataSource
extension OurMenuViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MenuItemTableViewCell = tableView.dequeueReusableCell(withIdentifier: "menuItemCell") as! MenuItemTableViewCell
        let item = menuItems[indexPath.row]
        
        //display data from MenuItems.plist
        cell.menuItemNameLabel?.text = item.name
        cell.ingredientsItemLabel?.text = item.ingredients
        cell.priceItemLabel?.text = item.price
        DataManager().downloadImage(from: URL(string: "http://platform.yafetrakan.com/images/"+item.image)!, view: cell.menuItemImageView!)
        if let discount = item.discount {
            cell.discountLabel?.text = discount
            cell.discountView?.isHidden = false
        } else {
            cell.discountView?.isHidden = true
        }
        
        cell.backgroundColor = UIColor.clear
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
}
