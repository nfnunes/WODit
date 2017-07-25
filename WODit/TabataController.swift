//
//  TabataController.swift
//  WODit
//
//  Created by Nuno on 19/12/2016.
//  Copyright © 2016 Nuno. All rights reserved.
//

import UIKit
import AVFoundation

class TabataController: UIViewController, EditTabataControllerDelegate {
    
    var timer: Timer?
    var workTime = 20
    var restTime = 10
    var reps = 1
    
    @IBOutlet weak var workDisplay: UILabel!
    @IBOutlet weak var restDisplay: UILabel!
    @IBOutlet weak var workLbl: UILabel!
    @IBOutlet weak var restLbl: UILabel!
    @IBOutlet weak var toggleBtn: UIButton!
    @IBOutlet weak var currentRepLbl: UILabel!
    @IBOutlet weak var lastRepLbl: UILabel!
    @IBOutlet weak var TabataSelected: UIButton!
    
    let somFinalTimer: SystemSoundID = 1010
    let somStartRest: SystemSoundID = 1005
    let somStartWork: SystemSoundID = 1023

    override func viewDidLoad() {
        super.viewDidLoad()
        
        TabataSelected.isSelected = true
        self.workDisplay.text = String(format: "%02d", self.workTime)
        self.restDisplay.text = String(format: "%02d", self.restTime)
    }
    
    @IBAction func toggleBtnPressed(_ sender: Any) {
        if timer != nil{
            toggleBtn.setImage(#imageLiteral(resourceName: "iconStart"), for: .normal)
            timer?.invalidate()
            timer = nil
        }
        else{
            toggleBtn.setImage(#imageLiteral(resourceName: "iconPause"), for: .normal)
            currentRepLbl.text = "\(reps)"
                timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){ _ in
                    if self.workTime > 0{
                        self.workTime -= 1
                        self.workDisplay.text = String(format: "%02d", self.workTime)
                    }
                    else if self.workTime == 0 && self.restTime > 0{
                        if self.restTime == 10{
                        AudioServicesPlaySystemSound(self.somStartRest)
                        }
                        self.restTime -= 1
                        self.restDisplay.text = String(format: "%02d", self.restTime)
                    }
                    else if self.workTime == 0 && self.restTime == 0 && self.reps < Int(self.lastRepLbl.text!)!{
                        AudioServicesPlaySystemSound(self.somStartWork)
                        self.reps += 1
                        self.workTime = 20
                        self.restTime = 10
                        self.workDisplay.text = String(format: "%02d", self.workTime)
                        self.restDisplay.text = String(format: "%02d", self.restTime)
                        self.currentRepLbl.text = "\(self.reps)"
                        
                    }
                        
                    else if self.restTime == 0 && self.reps >= Int(self.lastRepLbl.text!)!{
                        AudioServicesPlaySystemSound(self.somFinalTimer)
                        self.toggleBtn.setImage(#imageLiteral(resourceName: "iconStart"), for: .normal)
                        self.timer?.invalidate()
                        self.timer = nil
                    }
                }
        }
    }

    
    @IBAction func resetBtnPressed(_ sender: Any) {
        self.toggleBtn.setImage(#imageLiteral(resourceName: "iconStart"), for: .normal)
        self.timer?.invalidate()
        self.timer = nil
        self.workTime = 20
        self.restTime = 10
        self.reps = 1
        self.workDisplay.text = String(format: "%02d", self.workTime)
        self.restDisplay.text = String(format: "%02d", self.restTime)
        self.currentRepLbl.text = "\(self.reps)"
        
    }
    
    func EditTabataRounds(_ rounds: Int) {
        if rounds > 0{
            lastRepLbl.text = "\(rounds)"
        }
        else{
            lastRepLbl.text = "1"
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tabataEditVC = segue.destination as? EditTabataVC{
            tabataEditVC.delegate = self
        }
    }
}
