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
    
    @IBOutlet weak var ForTimeSelected: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ForTimeSelected.isSelected = true
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
