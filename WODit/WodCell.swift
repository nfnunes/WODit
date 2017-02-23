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
    
    func changeState(){
        wodLabelToBottom.isActive = !wodLabelToBottom.isActive
        wodExercToBottom.isActive = !wodExercToBottom.isActive
    /*    if selectedCellIndexPath != nil && selectedCellIndexPath == indexPath {
            
            currentCell.backgroundColor = UIColor(red: 0.11, green: 0.10, blue: 0.10, alpha: 1.0)
            selectedCellIndexPath = nil
        } else {
            selectedCellIndexPath = indexPath
            currentCell.backgroundColor = UIColor(red:0.22, green:0.22, blue:0.22, alpha:1.0)
        }*/
        self.setNeedsLayout()
        
        /*
         //  let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
         if selectedCellIndexPath != nil && selectedCellIndexPath == indexPath {
         
         currentCell.backgroundColor = UIColor(red: 0.11, green: 0.10, blue: 0.10, alpha: 1.0)
         selectedCellIndexPath = nil
         } else {
         selectedCellIndexPath = indexPath
         currentCell.backgroundColor = UIColor(red:0.22, green:0.22, blue:0.22, alpha:1.0)
         }
         */
    }

}
