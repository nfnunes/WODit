//
//  goWODAmrapVC.swift
//  WODit
//
//  Created by Nuno on 28/12/2016.
//  Copyright © 2016 Nuno. All rights reserved.
//

import UIKit

class goWODAmrapVC: UIViewController {

    var timer: Timer?
    //var currentTime = 1200 // 20min = 20*60
    
    @IBOutlet weak var wodNameLbl: UILabel!

    @IBOutlet weak var wodExercisesLbl: UITextView!
    @IBOutlet weak var amrapDisplay: UILabel!
    @IBOutlet weak var amrapToggleBtn: UIButton!
    //@IBOutlet weak var AmrapSelected: UIButton!
    
    private var _wodName: String = ""
    private var _wodExercises: String = ""
    private var currentTime: Int = 0
    
    var WodName: String
        {
        set
        {
            _wodName = newValue
        }
        get {
            return _wodName
        }
    }
    
    var WodExercises: String
        {
        set
        {
            _wodExercises = newValue
        }
        get {
            return _wodExercises
        }
    }
    
    var CurrentTime: Int
        {
        set
        {
            currentTime = newValue
        }
        get {
            return currentTime
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // AmrapSelected.isSelected = true
   
        
        SetupView()
    }
    
    @IBAction func amrapToggleBtnPressed(_ sender: Any) {
        if timer != nil{
            amrapToggleBtn.setImage(#imageLiteral(resourceName: "iconStart"), for: .normal)
            timer?.invalidate()
            timer = nil
        }
        else{
            amrapToggleBtn.setImage(#imageLiteral(resourceName: "iconPause"), for: .normal)
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){ _ in
                self.currentTime -= 1
                let minutes = String(format: "%02d", self.currentTime / 60)
                let seconds = String(format: "%02d", self.currentTime % 60)
                self.amrapDisplay.text = "\(minutes) : \(seconds)"
                
                if self.currentTime == 0{
                    self.amrapToggleBtn.setImage(#imageLiteral(resourceName: "iconStart"), for: .normal)
                    self.timer?.invalidate()
                    self.timer = nil
                }
            }
        }
    }

    
    @IBAction func resetBtnPressed(_ sender: Any) {
        amrapToggleBtn.setImage(#imageLiteral(resourceName: "iconStart"), for: .normal)
        timer?.invalidate()
        timer = nil
        currentTime = 1200
        let minutes = String(format: "%02d", self.currentTime / 60)
        let seconds = String(format: "%02d", self.currentTime % 60)
        self.amrapDisplay.text = "\(minutes) : \(seconds)"
    }
    
    func SetupView() {
        wodNameLbl.text = _wodName
        wodExercisesLbl.text = _wodExercises
        let minutes = String(format: "%02d", self.currentTime / 60)
        let seconds = String(format: "%02d", self.currentTime % 60)
        self.amrapDisplay.text = "\(minutes) : \(seconds)"
    }
    
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    


}
