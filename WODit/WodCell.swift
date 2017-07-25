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
    @IBOutlet weak var wodScoreLbl: UILabel!
    @IBOutlet weak var wodExerciseLbl: UILabel!
    

    @IBOutlet weak var wodLabelToBottom: NSLayoutConstraint!
    
    @IBOutlet weak var wodExercToBottom: NSLayoutConstraint!
    
    var tapAction: ((UITableViewCell) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(wod: WOD){
        
        wodScoreLbl.text = ""
        wodExerciseLbl.text = ""
        wodNameLbl.text = wod.name
        for item in wod.score{
            wodScoreLbl.text = wodScoreLbl.text! + item + "\r\n"
        }
        
        for item in wod.exercise{
            wodExerciseLbl.text = wodExerciseLbl.text! + item + "\r\n"
        }

    }
    
    
    @IBAction func goBtnPressed(_ sender: Any) {
        tapAction?(self)
    }
    

}
