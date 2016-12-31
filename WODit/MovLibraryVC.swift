//
//  MovLibraryVC.swift
//  WODit
//
//  Created by Nuno on 31/12/2016.
//  Copyright © 2016 Nuno. All rights reserved.
//

import UIKit
import SwiftyJSON

class MovLibraryVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var movs = [EXERCISE]()
    var selectedCellIndexPath: IndexPath?

    @IBOutlet weak var movSearchBar: UISearchBar!
    @IBOutlet weak var movTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        movSearchBar.delegate = self
        movTableView.dataSource = self
        movTableView.delegate = self
        
        let path = Bundle.main.path(forResource: "MOVs", ofType: "json")
        let jsonData = NSData(contentsOfFile: path!) as Data!
        let readableJSON = JSON(data: jsonData!)
        
        for (_,subJson):(String,JSON) in readableJSON{
            let name = subJson["name"].string
            let description = subJson["description"].string
            
            let url = subJson["url"].string
            
            movs.append(EXERCISE(name: name!, description: description!, url: url! ))
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "movCell", for: indexPath) as? MovCell{
            
            let mov: EXERCISE!
            
            mov = movs[indexPath.row]
            cell.updateUI(mov: mov)
            return cell
            
        }
        else{
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return movs.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedCellIndexPath == indexPath {
            return 400
        }
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
        if selectedCellIndexPath != nil && selectedCellIndexPath == indexPath {
            
            currentCell.backgroundColor = UIColor(red: 0.11, green: 0.10, blue: 0.10, alpha: 1.0)
            selectedCellIndexPath = nil
        } else {
            selectedCellIndexPath = indexPath
            currentCell.backgroundColor = UIColor(red:0.22, green:0.22, blue:0.22, alpha:1.0)
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
        
        if selectedCellIndexPath != nil {
            // This ensures, that the cell is fully visible once expanded
            tableView.scrollToRow(at: indexPath, at: .none, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let currentCell = tableView.cellForRow(at: indexPath) as UITableViewCell?{
            currentCell.backgroundColor = UIColor(red: 0.11, green: 0.10, blue: 0.10, alpha: 1.0)
        }
    }


}
