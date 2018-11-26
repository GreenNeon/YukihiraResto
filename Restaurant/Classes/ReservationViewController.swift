//
//  ReservationViewController.swift
//  Restaurant
//
//  Created by AppsFoundation on 8/28/15.
//  Copyright © 2015 AppsFoundation. All rights reserved.
//

import UIKit

enum ReservationCell: Int {
    case Location = 0
    case NumberOfGuests
    case Phone
    case MakeReservation
    case Count
}

class ReservationViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView?
    var cellLocation: ReservationLocationTableViewCell?
    var cellGuest: NumberOfGuestsTableViewCell?
    var cellMake: MakeReservationTableViewCell?
    let UserEdit: User = DataManager().LoadUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellLocation = self.tableView!.dequeueReusableCell(withIdentifier: "reservationCell") as! ReservationLocationTableViewCell
        cellGuest = self.tableView!.dequeueReusableCell(withIdentifier: "numberOfGuestsCell") as! NumberOfGuestsTableViewCell
        cellMake = self.tableView!.dequeueReusableCell(withIdentifier: "makeReservationCell") as! MakeReservationTableViewCell
        
        DataManager().DoGetReservasi(id: UserEdit.id, view: self) {
            responseObject, error in
            
            if(responseObject?.id == -1) {
                self.cellMake?.SetLabel(text: "MAKE RESERVATION")
            } else {
                
                self.cellGuest?.SetGuest(guest: (responseObject?.jumlahOrang) ?? 0)
                switch responseObject?.tempat {
                case "Jakarta":
                    self.cellLocation?.SetLocation(index: 1)
                    break;
                default:
                    self.cellLocation?.SetLocation(index: 0)
                }
                self.cellMake?.SetLabel(text: "EDIT RESERVATION")
            }
            self.tableView?.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - UITableViewDataSource
extension ReservationViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ReservationCell.Count.rawValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case ReservationCell.Location.rawValue:
            cellLocation!.backgroundColor = UIColor.clear
            return cellLocation!
        case ReservationCell.NumberOfGuests.rawValue:
            cellGuest!.backgroundColor = UIColor.clear
            return cellGuest!
        case ReservationCell.Phone.rawValue:
            let cell: PhoneNumberTableViewCell = tableView.dequeueReusableCell(withIdentifier: "phoneNumberCell") as! PhoneNumberTableViewCell
            cell.backgroundColor = UIColor.clear
            return cell
        case ReservationCell.MakeReservation.rawValue:
            cellMake!.backgroundColor = UIColor.clear
            return cellMake!
        default:
            return UITableViewCell() //return empty cell
        }
    }
}

// MARK: - UITableViewDelegate
extension ReservationViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == ReservationCell.MakeReservation.rawValue {
            if(UserEdit.id == -1) {
                let alert = UIAlertView(title: "Thank You", message: "You have booked table. Thanks for your reservation.", delegate: nil, cancelButtonTitle: "Ok")
                alert.show()
            } else {
                let alert = UIAlertView(title: "Nice", message: "You have update booked. Thanks for your time.", delegate: nil, cancelButtonTitle: "Ok")
                alert.show()
            }
        }
    }
}
