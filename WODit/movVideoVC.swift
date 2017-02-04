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
    @IBOutlet weak var videoName: UILabel!
    
    
    private var _exercise: String = ""
    private var _name: String = ""
    
    var exercise: String{
        set{
            _exercise = newValue
        }
        get{
            return _exercise
        }
    }
    
    var name: String{
        set{
            _name = newValue
        }
        get{
            return _name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.delegate = self
    }
    
    func SetupView() {
        videoName.text = name
        callVideo()
    }
    
    func callVideo(){
        let requestURL = URL(string: exercise)
        let request = URLRequest(url: requestURL!)
        webView.loadRequest(request)
    }

    @IBAction func backMovLibraryBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
