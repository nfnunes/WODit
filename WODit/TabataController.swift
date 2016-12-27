//
//  TabataController.swift
//  WODit
//
//  Created by Nuno on 19/12/2016.
//  Copyright © 2016 Nuno. All rights reserved.
//

import UIKit

class TabataController: UIViewController, editTabataControllerDelegate {
    
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
                        self.restTime -= 1
                        self.restDisplay.text = String(format: "%02d", self.restTime)
                    }
                    else if self.workTime == 0 && self.restTime == 0 && self.reps < Int(self.lastRepLbl.text!)!{
                        self.reps += 1
                        self.workTime = 20
                        self.restTime = 10
                        self.workDisplay.text = String(format: "%02d", self.workTime)
                        self.restDisplay.text = String(format: "%02d", self.restTime)
                        self.currentRepLbl.text = "\(self.reps)"
                        
                    }
                        
                    else if self.restTime == 0 && self.reps >= Int(self.lastRepLbl.text!)!{
                        self.toggleBtn.setImage(#imageLiteral(resourceName: "iconStart"), for: .normal)
                        self.timer?.invalidate()
                        self.timer = nil
                   //     self.workDisplay.text = String(format: "%02d", self.workTime)
                   //     self.restDisplay.text = String(format: "%02d", self.restTime)
                   //     self.currentRepLbl.text = "\(self.reps)"
                        
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
    
    func editTabataRounds(_ rounds: String) {
        if rounds > "0"{
            lastRepLbl.text = rounds
        }
        else{
            lastRepLbl.text = "1"
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let TabataEditVC = segue.destination as? TabataEditVC{
            TabataEditVC.delegate = self
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
    
    

}
