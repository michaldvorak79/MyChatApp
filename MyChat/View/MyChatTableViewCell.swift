//
//  MyChatTableCellTableViewCell.swift
//  MyChat
//
//  Created by Michal on 01.03.18.
//  Copyright © 2018 Michal. All rights reserved.
//

import UIKit

class MyChatTableViewCell: UITableViewCell {

    @IBOutlet var lblName : UILabel!
    @IBOutlet var lblMessage : UILabel!
    
    var name : String = ""
    var message : String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblName.text = name
        lblMessage.text = message
    }

}
