//
//  MovCell.swift
//  WODit
//
//  Created by Nuno on 31/12/2016.
//  Copyright © 2016 Nuno. All rights reserved.
//

import UIKit

class MovCell: UITableViewCell {
    
    
    @IBOutlet weak var movNameLbl: UILabel!
    @IBOutlet weak var movDescriptionLbl: UILabel!
    
    var tapAction: ((UITableViewCell) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
 /*   override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }*/
    
    func updateUI(mov: EXERCISE){
        
        movNameLbl.text = mov.name
    }
    
    
 /*   @IBAction func goBtnPressed(_ sender: Any) {
        tapAction?(self)
    }*/
    
}
