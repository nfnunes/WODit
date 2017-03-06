//
//  EmomController.swift
//  WODit
//
//  Created by Nuno on 19/12/2016.
//  Copyright © 2016 Nuno. All rights reserved.
//

import UIKit
import AVFoundation

class EmomController: UIViewController, editAmrapControllerDelegate {

    @IBOutlet weak var emonMainDisplay: UILabel!
    @IBOutlet weak var emonMinuteDisplay: UILabel!
    @IBOutlet weak var emonToggleBtn: UIButton!
    @IBOutlet weak var EmonSelected: UIButton!
    
    let somFinalTimer: SystemSoundID = 1010
    let somMinuto: SystemSoundID = 1005
    
    
    var timer: Timer?
    var currentTime = 600 // 10min = 10*60
    var currentMinute = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EmonSelected.isSelected = true

        let minutes = String(format: "%02d", self.currentTime / 60)
        let seconds = String(format: "%02d", self.currentTime % 60)
        self.emonMainDisplay.text = "\(minutes) : \(seconds)"
        self.emonMinuteDisplay.text = "01 : 00"
    }
    
    @IBAction func emonToggleBtnPressed(_ sender: Any) {
        if timer != nil{
            emonToggleBtn.setImage(#imageLiteral(resourceName: "iconStart"), for: .normal)
            timer?.invalidate()
            timer = nil
        }
        else{
            emonToggleBtn.setImage(#imageLiteral(resourceName: "iconPause"), for: .normal)
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){ _ in
                self.currentTime -= 1
                self.currentMinute -= 1
                let minutesMain = String(format: "%02d", self.currentTime / 60)
                let secondsMain = String(format: "%02d", self.currentTime % 60)
                let minutesSec = String(format: "%02d", self.currentMinute / 60)
                let secondsSec = String(format: "%02d", self.currentMinute % 60)
                self.emonMainDisplay.text = "\(minutesMain) : \(secondsMain)"
                self.emonMinuteDisplay.text = "\(minutesSec) : \(secondsSec)"
                
                if self.currentMinute == 0 && self.currentTime > 0{
                    AudioServicesPlaySystemSound(self.somMinuto)
                    self.currentMinute = 60
                }
                
                if self.currentTime == 0{
                    AudioServicesPlaySystemSound(self.somFinalTimer)
                    self.emonToggleBtn.setImage(#imageLiteral(resourceName: "iconStart"), for: .normal)
                    self.timer?.invalidate()
                    self.timer = nil
                }
            }
        }
    }
    
    @IBAction func resetBtnPressed(_ sender: Any) {
        emonToggleBtn.setImage(#imageLiteral(resourceName: "iconStart"), for: .normal)
        timer?.invalidate()
        timer = nil
        currentTime = 600
        currentMinute = 60
        let minutesMain = String(format: "%02d", self.currentTime / 60)
        let secondsMain = String(format: "%02d", self.currentTime % 60)
        let minutesSec = String(format: "%02d", self.currentMinute / 60)
        let secondsSec = String(format: "%02d", self.currentMinute % 60)
        self.emonMainDisplay.text = "\(minutesMain) : \(secondsMain)"
        self.emonMinuteDisplay.text = "\(minutesSec) : \(secondsSec)"
    }
    
    func editAmrapTime(_ minutes: Int, _ seconds: Int) {
        currentTime = minutes*60 + seconds
        
        let minutes = String(format: "%02d", self.currentTime / 60)
        let seconds = String(format: "%02d", self.currentTime % 60)
        emonMainDisplay.text = "\(minutes) : \(seconds)"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let editAmrapController = segue.destination as? editAmrapController{
            editAmrapController.delegate = self
        }
    }
    
    @IBAction func goWODsBtnPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "WODs") as UIViewController
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func goWODsBtn2Pressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "WODs") as UIViewController
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func goMOVsBtnPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MOVs") as UIViewController
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func goMOVsBtn2Pressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MOVs") as UIViewController
        present(vc, animated: true, completion: nil)
    }

}
