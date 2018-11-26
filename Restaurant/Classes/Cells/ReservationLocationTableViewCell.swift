//
//  ReservationLocationTableViewCell.swift
//  Restaurant
//
//  Created by AppsFoundation on 8/27/15.
//  Copyright © 2015 AppsFoundation. All rights reserved.
//

import UIKit

class ReservationLocationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var locationLabel: UILabel?
    @IBOutlet weak var distanceLabel: UILabel?
    let PlaceLocation: [String] = [
        "Jalan Raya Bantul, KM 9\n(0812)123-0023\nBantul Suite,CC 8967",
        "Jalan Kusuma Negara, KM 1\n(0812)123-0203\nBoshe Club,CC 9067",
        "Jalan Solo KM 12\n(0812)123-1903\nJoga Club,CC 9067"
    ]
    var TableNum: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Actions
    @IBAction func leftSwipe(_ sender: AnyObject) {
        print("Previous location")
        previousLocation()
    }
    
    @IBAction func rightSwipe(_ sender: AnyObject) {
        print("Next location")
        nextLocation()
    }
    
    func SetLocation(index: Int) {
        for n in 0...index {
            print(n)
            nextLocation()
        }
    }
    
    @IBAction func onPreviosLocation(_ sender: AnyObject) {
        print("Previous location")
        previousLocation()
        
        distanceLabel?.text = "2,5 Mi"
        
    }
    
    @IBAction func onNextLocation(_ sender: AnyObject) {
        print("Next location")
        nextLocation()
        
        distanceLabel?.text = "2,5 Mi"
    }
    
    // MARK: Private Methods
    private func previousLocation() {
        UIView.animate(withDuration: 0.2) { () -> Void in
            self.locationLabel?.alpha = 0.0
        }
        
        if TableNum > 0 {
            TableNum -= 1
            locationLabel?.text = PlaceLocation[TableNum]
        }
        
        UIView.animate(withDuration: 0.1) { () -> Void in
            self.locationLabel?.alpha = 1.0
        }
    }
    
    private func nextLocation() {
        UIView.animate(withDuration: 0.2) { () -> Void in
            self.locationLabel?.alpha = 0.0
        }
        
        if TableNum < 2 {
            TableNum += 1
            locationLabel?.text = PlaceLocation[TableNum]
        }
        
        UIView.animate(withDuration: 0.1) { () -> Void in
            self.locationLabel?.alpha = 1.0
        }
    }
}
