//
//  MakeReservationTableViewCell.swift
//  Restaurant
//
//  Created by AppsFoundation on 8/27/15.
//  Copyright © 2015 AppsFoundation. All rights reserved.
//

import UIKit

class MakeReservationTableViewCell: UITableViewCell {

    @IBOutlet weak var LabelMake: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func SetLabel(text: String) {
        self.LabelMake.text = text
    }
}
