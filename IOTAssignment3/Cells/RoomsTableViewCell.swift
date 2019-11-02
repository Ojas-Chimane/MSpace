//
//  RoomsTableViewCell.swift
//  IOTAssignment3
//
//  Created by Ojas Chimane on 29/10/19.
//  Copyright © 2019 Ojas Chimane Org. All rights reserved.
//

import UIKit

class RoomsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet weak var campusNameLabel: UILabel!
    @IBOutlet weak var vacantSeatsLabel: UILabel!
    
    @IBOutlet weak var statusColorView: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        statusColorView.layer.cornerRadius = 5;
        statusColorView.layer.masksToBounds = true;
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
