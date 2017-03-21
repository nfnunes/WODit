//
//  ViewController.swift
//  WODit
//
//  Created by Nuno on 04/12/2016.
//  Copyright © 2016 Nuno. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func goTimersBtnPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Timers", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Timers") as UIViewController
        present(vc, animated: true, completion: nil)
    }

}
