//
//  movVideoVC.swift
//  WODit
//
//  Created by Nuno on 14/01/2017.
//  Copyright © 2017 Nuno. All rights reserved.
//

import UIKit

class movVideoVC: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    
    private var _exercise: String?
    
    var exercise: String{
        get{
            return _exercise!
        }
        set{
            _exercise = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.delegate = self
        print(exercise)
        
    //    let requestURL = URL(string: Exercise.url)
    //    let request = URLRequest(url: requestURL!)
    //    webView.loadRequest(request)
    }

}
