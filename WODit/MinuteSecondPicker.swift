//
//  MinuteSecondPicker.swift
//  WODit
//
//  Created by Nuno on 18/12/2016.
//  Copyright © 2016 Nuno. All rights reserved.
//

import UIKit

class MinuteSecondPicker: UIPickerView, UIPickerViewDelegate {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBOutlet weak var timeSegueLabel: UILabel!
    
    let minutes = Array(0...9)
    let seconds = Array(0...59)
    
    var recievedString: String = ""
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    


    override func numberOfRows(inComponent component: Int) -> Int {
        //row = [repeatPickerView selectedRowInComponent:0];
        var row = pickerView.selectedRow(inComponent: 0)
        print("this is the pickerView\(row)")
        
        if component == 0 {
            return minutes.count
        }
            
        else {
            return seconds.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        
        if component == 0 {
            return String(minutes[row])
        } else {
            
            return String(seconds[row])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeSegueLabel.text = recievedString
        
    }

}
