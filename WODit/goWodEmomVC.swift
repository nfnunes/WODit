//
//  goWodEmomVC.swift
//  WODit
//
//  Created by Nuno on 01/01/2017.
//  Copyright © 2017 Nuno. All rights reserved.
//

import UIKit

class goWodEmomVC: UIViewController {
    
    var timer: Timer?
    var currentMinute = 60
    
    @IBOutlet weak var wodNameLbl: UILabel!
    @IBOutlet weak var emomMainDisplay: UILabel!
    @IBOutlet weak var emomMinuteDisplay: UILabel!
    @IBOutlet weak var emomToggleBtn: UIButton!
    @IBOutlet weak var wodExercisesLbl: UITextView!

    private var _wodName: String = ""
    private var _wodExercises: String = ""
    private var currentTime: Int = 0
    private var initTime: Int = 0
    
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

    
    @IBAction func emomToggleBtnPressed(_ sender: Any) {
        if timer != nil{
            emomToggleBtn.setImage(#imageLiteral(resourceName: "iconStart"), for: .normal)
            timer?.invalidate()
            timer = nil
        }
        else{
            emomToggleBtn.setImage(#imageLiteral(resourceName: "iconPause"), for: .normal)
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){ _ in
                self.currentTime -= 1
                self.currentMinute -= 1
                let minutesMain = String(format: "%02d", self.currentTime / 60)
                let secondsMain = String(format: "%02d", self.currentTime % 60)
                let minutesSec = String(format: "%02d", self.currentMinute / 60)
                let secondsSec = String(format: "%02d", self.currentMinute % 60)
                self.emomMainDisplay.text = "\(minutesMain) : \(secondsMain)"
                self.emomMinuteDisplay.text = "\(minutesSec) : \(secondsSec)"
                
                if self.currentMinute == 0 && self.currentTime > 0{
                    self.currentMinute = 60
                }
                
                if self.currentTime == 0{
                    self.emomToggleBtn.setImage(#imageLiteral(resourceName: "iconStart"), for: .normal)
                    self.timer?.invalidate()
                    self.timer = nil
                }
            }
        }
    }
    
    
    @IBAction func resetBtnPressed(_ sender: Any) {
        emomToggleBtn.setImage(#imageLiteral(resourceName: "iconStart"), for: .normal)
        timer?.invalidate()
        timer = nil
        currentTime = initTime
        currentMinute = 60
        let minutesMain = String(format: "%02d", self.currentTime / 60)
        let secondsMain = String(format: "%02d", self.currentTime % 60)
        let minutesSec = String(format: "%02d", self.currentMinute / 60)
        let secondsSec = String(format: "%02d", self.currentMinute % 60)
        self.emomMainDisplay.text = "\(minutesMain) : \(secondsMain)"
        self.emomMinuteDisplay.text = "\(minutesSec) : \(secondsSec)"
    }
    
    func SetupView() {
        wodNameLbl.text = _wodName
        wodExercisesLbl.text = _wodExercises
        let minutes = String(format: "%02d", self.currentTime / 60)
        let seconds = String(format: "%02d", self.currentTime % 60)
        self.emomMainDisplay.text = "\(minutes) : \(seconds)"
        self.emomMinuteDisplay.text = "01 : 00"
        initTime = currentTime
    }

    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
