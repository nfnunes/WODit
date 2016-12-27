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
        
        //titleLbl.addShadow()
        
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.blue
        shadow.shadowBlurRadius = 20
        shadow.shadowOffset = CGSize(width: 0.0, height: 5.0)
        //layer.shadowOpacity = 0.5
        //layer.shadowPath = shadowPath.cgPath
        //self.setNeedsLayout()  //Indica que esta view precisa de ser actualizada no próximo ciclo de actualização
        //self.layoutIfNeeded()  //Verifica se a view precisa de ser actualizada (linha acima) e chama o layoutSubview se precisar. É assim que o layout Subviews deve ser chamado
        let myAttribute = [ NSShadowAttributeName: shadow ]
        let myString = NSMutableAttributedString(string: "WODit", attributes: myAttribute )
        
        titleLbl.attributedText = myString
    }

    @IBAction func goTimersBtnPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Timers", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Timers") as UIViewController
        present(vc, animated: true, completion: nil)
    }

}


extension UIView {
    
    func addShadow(){
        
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.white.cgColor
        shadow.shadowBlurRadius = 20
        shadow.shadowOffset = CGSize(width: 0.0, height: 5.0)
        //layer.shadowOpacity = 0.5
        //layer.shadowPath = shadowPath.cgPath
        //self.setNeedsLayout()  //Indica que esta view precisa de ser actualizada no próximo ciclo de actualização
        //self.layoutIfNeeded()  //Verifica se a view precisa de ser actualizada (linha acima) e chama o layoutSubview se precisar. É assim que o layout Subviews deve ser chamado
        let myAttribute = [ NSShadowAttributeName: shadow ]
        
    }
    
}

extension UILabel{
    
    func requiredHeight() -> CGFloat{
        
        let label:UILabel = UILabel(frame: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.frame.width, height: CGFloat.greatestFiniteMagnitude)))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = self.font
        label.text = self.text
        
        label.sizeToFit()
        
        return label.frame.height
    }
}

