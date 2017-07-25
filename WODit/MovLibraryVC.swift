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
    var filteredMovs = [EXERCISE]()
    
    var inSearchMode = false

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
        
        // Get list of exercises and its video urls
        for (_,subJson):(String,JSON) in readableJSON{
            let name = subJson["name"].string
            let url = subJson["url"].string
            
            movs.append(EXERCISE(name: name!, url: url! ))
        }
        
        self.movTableView.rowHeight = UITableViewAutomaticDimension
        self.movTableView.estimatedRowHeight = 55
    }
    
    // Fill the tableview with the list of movements
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "movCell", for: indexPath) as? MovCell{
            
            let mov: EXERCISE!
            
            if inSearchMode {
                mov = filteredMovs[indexPath.row]
            }
            else{
                mov = movs[indexPath.row]
            }
            cell.updateUI(mov: mov)
            
            //When Play button is pressed
            cell.tapAction = { (cell) in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
               
                let vc = storyboard.instantiateViewController(withIdentifier: "movVideoVC") as! MovVideoVC
                self.present(vc, animated: true, completion: {
                    vc.exercise = mov.url
                    vc.name = mov.name
                    vc.SetupView()
                })
            }
            
            return cell
            
        }
        else{
            return UITableViewCell()
        }
    }
    
    // Set number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if inSearchMode{
            return filteredMovs.count
        }
        else{
            return movs.count
        }
        
    }

    // Set number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Cancel the text search
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    // Search for a movement
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if movSearchBar.text == nil || movSearchBar.text == "" {
            inSearchMode = false
            movTableView.reloadData()
            view.endEditing(true)
        }else{
            inSearchMode = true
            let entry = movSearchBar.text!.lowercased()
            filteredMovs = movs.filter({$0.name.lowercased().range(of: entry) != nil })
            movTableView.reloadData()
        }
    }

}
