//
//  TraderCustomCellTable.swift
//  FinalSwfitProject
//
//  Created by i219pc11 on 5/26/16.
//  Copyright © 2016 iug. All rights reserved.
//

import UIKit

class TraderCustomCellTable: UITableViewCell {

    
    @IBOutlet weak var traderName: UILabel!
    @IBOutlet weak var traderPhoneNumber: UILabel!
    @IBOutlet weak var traderImage: UIImageView!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
          }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        // Configure the view for the selected state
    }
    
   
}
