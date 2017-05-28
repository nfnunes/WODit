//
//  AmrapController.swift
//  WODit
//
//  Created by Nuno on 17/12/2016.
//  Copyright © 2016 Nuno. All rights reserved.
//

import UIKit
import AVFoundation

class AmrapController: UIViewController, editAmrapControllerDelegate {
    
    var timer: Timer?
    var currentTime = 1200 // 20min = 20*60

    @IBOutlet weak var amrapDisplay: UILabel!
    @IBOutlet weak var amrapToggleBtn: UIButton!
    @IBOutlet weak var AmrapSelected: UIButton!
    
    let somFinalTimer: SystemSoundID = 1010
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AmrapSelected.isSelected = true

        let minutes = String(format: "%02d", self.currentTime / 60)
        let seconds = String(format: "%02d", self.currentTime % 60)
        self.amrapDisplay.text = "\(minutes) : \(seconds)"
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
                    AudioServicesPlaySystemSound(self.somFinalTimer)
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
    
    func editAmrapTime(_ minutes: Int, _ seconds: Int) {
        currentTime = minutes*60 + seconds
        
        let minutes = String(format: "%02d", self.currentTime / 60)
        let seconds = String(format: "%02d", self.currentTime % 60)
        amrapDisplay.text = "\(minutes) : \(seconds)"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let editAmrapController = segue.destination as? editAmrapController{
            editAmrapController.delegate = self
        }
    }
}
