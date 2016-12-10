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
    var scoresWod = [String]()
    var selectedCellIndexPath: IndexPath?
    
    @IBOutlet weak var wodtableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        wodtableView.delegate = self
        wodtableView.dataSource = self

        // Do any additional setup after loading the view.
        
        
        let path = Bundle.main.path(forResource: "WODs", ofType: "json")
        let jsonData = NSData(contentsOfFile: path!) as Data!
        let readableJSON = JSON(data: jsonData!)
        	
        for (_,subJson):(String,JSON) in readableJSON{
            let name = subJson["name"].string
            for item in subJson["score"].arrayValue{
                print(item)
                scoresWod.append("\(item)")
            }
            print("----")
            print("scoresWod = \(scoresWod)")
            print("....")
            
            
            wods.append(WOD(name: name!, score: scoresWod ))
            scoresWod.removeAll()
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
        if selectedCellIndexPath == indexPath {
            return 132
        }
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedCellIndexPath != nil && selectedCellIndexPath == indexPath {
            selectedCellIndexPath = nil
        } else {
            selectedCellIndexPath = indexPath
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
        if selectedCellIndexPath != nil {
            // This ensures, that the cell is fully visible once expanded
            tableView.scrollToRow(at: indexPath, at: .none, animated: true)
        }
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }


}
