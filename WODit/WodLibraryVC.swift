//
//  WodLibraryVC.swift
//  WODit
//
//  Created by Nuno on 06/12/2016.
//  Copyright © 2016 Nuno. All rights reserved.
//

import UIKit
import SwiftyJSON

class WodLibraryVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var  wods = [WOD]()
    
    @IBOutlet weak var wodtableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        wodtableView.delegate = self
        wodtableView.dataSource = self

        // Do any additional setup after loading the view.
        
        let path = Bundle.main.path(forResource: "WODs", ofType: "json")
        let jsonData = NSData(contentsOfFile: path!) as Data!
        let readableJSON = JSON(data: jsonData!)
        
        if let name = readableJSON[0]["name"].string {
            //Now you got your value
            wods.append(WOD(name: name))
        }
 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "wodCell", for: indexPath) as? WodCell{
            
            let wod = wods[indexPath.row]
            
            cell.updateUI(wod: wod)
            
            return cell
        }
        else{
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wods.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }


}
