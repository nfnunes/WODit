//
//  TabataEditVC.swift
//  WODit
//
//  Created by Nuno on 21/12/2016.
//  Copyright © 2016 Nuno. All rights reserved.
//

import UIKit

class TabataEditVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    weak var delegate: editTabataControllerDelegate?
    
    @IBOutlet weak var roundsPicker: UIPickerView!
    
    var rounds = 0
    
    let roundsDatabase =
        [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundsPicker.delegate = self
        roundsPicker.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return roundsDatabase.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            rounds = roundsDatabase[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView
    {
        let pickerLabel = UILabel()
        pickerLabel.textColor = UIColor.orange
        pickerLabel.text = String(format: "%02d",roundsDatabase[row])
        pickerLabel.font = UIFont(name: "Avenir Medium", size: 60)
        pickerLabel.textAlignment = NSTextAlignment.center
        return pickerLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 80
    }

    
    @IBAction func CancelBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func SaveBtnPressed(_ sender: Any) {
        delegate?.editTabataRounds(rounds)
        self.dismiss(animated: true, completion: nil)
    }

}
