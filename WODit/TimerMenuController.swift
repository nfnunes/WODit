//
//  TimerMenuController.swift
//  WODit
//
//  Created by Nuno on 19/12/2016.
//  Copyright © 2016 Nuno. All rights reserved.
//

import UIKit

class TimerMenuController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
