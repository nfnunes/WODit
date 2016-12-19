//
//  ForTimeController.swift
//  WODit
//
//  Created by Nuno on 17/12/2016.
//  Copyright © 2016 Nuno. All rights reserved.
//

import UIKit

class ForTimeController: UIViewController {
    
    var timer: Timer?
    var currentTime = 0

    @IBOutlet weak var stopWatchDisplay: UILabel!
    @IBOutlet weak var stopWatchToggleBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func stopWatchToggleBtnPressed(_ sender: Any) {
        if timer != nil{
            stopWatchToggleBtn.setImage(#imageLiteral(resourceName: "iconStart"), for: .normal)
            timer?.invalidate()
            timer = nil
        }
        else{
            stopWatchToggleBtn.setImage(#imageLiteral(resourceName: "iconPause"), for: .normal)
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){ _ in
                self.currentTime += 1
                let minutes = String(format: "%02d", self.currentTime / 60)
                let seconds = String(format: "%02d", self.currentTime % 60)
                self.stopWatchDisplay.text = "\(minutes) : \(seconds)"
            }
        }
    }
    
    @IBAction func resetBtnPressed(_ sender: Any) {
        
        stopWatchToggleBtn.setImage(#imageLiteral(resourceName: "iconStart"), for: .normal)
        timer?.invalidate()
        timer = nil
        currentTime = 0
        stopWatchDisplay.text = "00 : 00"
    }
    
}
