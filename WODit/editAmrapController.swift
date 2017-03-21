//
//  editAmrapController.swift
//  WODit
//
//  Created by Nuno on 17/12/2016.
//  Copyright © 2016 Nuno. All rights reserved.
//

import UIKit

class editAmrapController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    weak var delegate: editAmrapControllerDelegate?

    @IBOutlet weak var timePicker: UIPickerView!
    
    var minutes = 0
    var seconds = 0
    
    let timeDatabase = [
        [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59],
        [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timePicker.delegate = self
        timePicker.dataSource = self
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return timeDatabase.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timeDatabase[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch(component){
        case 0:
            minutes = timeDatabase[component][row]
        case 1:
            seconds = timeDatabase[component][row]
        default: break
            
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView
    {
        let pickerLabel = UILabel()
        pickerLabel.textColor = UIColor.orange
        pickerLabel.text = String(format: "%02d",timeDatabase[component][row])
        pickerLabel.font = UIFont(name: "Avenir Medium", size: 60) // In this use your custom font
        pickerLabel.textAlignment = NSTextAlignment.center
        return pickerLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 80
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        delegate?.editAmrapTime(minutes, seconds)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
