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
    
    private var _exercise: EXERCISE!
    
    var exercise: EXERCISE{
        get{
            return _exercise
        }
        set{
            _exercise = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.delegate = self
        let requestURL = URL(string: exercise.url)
        let request = URLRequest(url: requestURL!)
        webView.loadRequest(request)
    }
    
   /* func webViewDidFinishLoad(_ webView: UIWebView) {

        let css = ".container {position: relative; width: 100%; height: 0; padding-bottom: 56.25%; } .video { position: absolute; top: 0; left: 0; width: 100%; height: 100%;}"
        
        var js = "var styleNode = document.createElement('style')"
            js = js + "styleNode.type = \"text/css\""
            js = js + "var styleText = document.createTextNode('%@')"
            js = js + "styleNode.appendChild(styleText)"
            js = js + "document.getElementsByTagName('head')[0].appendChild(styleNode)"
            js = js + css
        
        self.webView.stringByEvaluatingJavaScript(from: js)
        
        print(js)

    }*/

}
