//
//  TabataEditVC.swift
//  WODit
//
//  Created by Nuno on 21/12/2016.
//  Copyright © 2016 Nuno. All rights reserved.
//

import UIKit

class TabataEditVC: UIViewController {
    
    weak var delegate: editTabataControllerDelegate?
    
    
    @IBOutlet weak var roundsTxtField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func CancelBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func SaveBtnPressed(_ sender: Any) {
        delegate?.editTabataRounds(roundsTxtField.text!)
        self.dismiss(animated: true, completion: nil)
    }
    



}
