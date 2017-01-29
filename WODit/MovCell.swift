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
    
    func updateUI(mov: EXERCISE){
        
        movNameLbl.text = mov.name
    }
    
    
    @IBAction func playBtnPressed(_ sender: Any) {
        tapAction?(self)
    }
    
}
