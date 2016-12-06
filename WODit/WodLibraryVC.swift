//
//  WodLibraryVC.swift
//  WODit
//
//  Created by Nuno on 06/12/2016.
//  Copyright © 2016 Nuno. All rights reserved.
//

import UIKit

class WodLibraryVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var  wods = [WOD]()
    
    @IBOutlet weak var wodtableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let p1 = WOD(name: "wod1")
        let p2 = WOD(name: "wod2")
        let p3 = WOD(name: "wod3")
        let p4 = WOD(name: "wod4")
        let p5 = WOD(name: "wod5")
        
        wods.append(p1)
        wods.append(p2)
        wods.append(p3)
        wods.append(p4)
        wods.append(p5)
        
        wodtableView.delegate = self
        wodtableView.dataSource = self

        // Do any additional setup after loading the view.
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
    


}
