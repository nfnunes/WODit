//
//  WodCell.swift
//  WODit
//
//  Created by Nuno on 06/12/2016.
//  Copyright © 2016 Nuno. All rights reserved.
//

import UIKit

class WodCell: UITableViewCell {


    @IBOutlet weak var wodNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(wod: WOD){
        
        wodNameLbl.text = wod.name
        
    }
    

}
