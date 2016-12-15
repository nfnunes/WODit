//
//  WodLibraryVC.swift
//  WODit
//
//  Created by Nuno on 06/12/2016.
//  Copyright © 2016 Nuno. All rights reserved.
//

import UIKit
import SwiftyJSON

class WodLibraryVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var wods = [WOD]()
    var scoresWod = [String]()
    var exercisesWod = [String]()
    var selectedCellIndexPath: IndexPath?
    
    @IBOutlet weak var wodtableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var inSearchMode = false
    
    var wodSearchController: UISearchController!
    
    var filteredWods = [WOD]()
    var shouldShowSearchResults = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        wodtableView.delegate = self
        wodtableView.dataSource = self
        searchBar.delegate = self

        let path = Bundle.main.path(forResource: "WODs", ofType: "json")
        let jsonData = NSData(contentsOfFile: path!) as Data!
        let readableJSON = JSON(data: jsonData!)
        	
        for (_,subJson):(String,JSON) in readableJSON{
            let name = subJson["name"].string
            for item in subJson["score"].arrayValue{
                scoresWod.append("\(item)")
            }
            
            for item in subJson["exercise"].arrayValue{
                exercisesWod.append("\(item)")
            }

            wods.append(WOD(name: name!, score: scoresWod, exercise: exercisesWod ))
            scoresWod.removeAll()
            exercisesWod.removeAll()
        }
       // wodtableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "wodCell", for: indexPath) as? WodCell{
            
            let wod: WOD!
            
            if inSearchMode {
                wod = filteredWods[indexPath.row]
                cell.updateUI(wod: wod)
                
            }
            else{
                wod = wods[indexPath.row]
                cell.updateUI(wod: wod)
            }
            
            return cell
            
        }
        else{
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if inSearchMode{
            return filteredWods.count
        }
        else{
            return wods.count
        }
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
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            wodtableView.reloadData()
            view.endEditing(true)
        }else{
            inSearchMode = true
            
            let entry = searchBar.text!.lowercased()
            filteredWods = wods.filter({$0.name.lowercased().range(of: entry) != nil })
            wodtableView.reloadData()
        }
        
    }
    

    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }


}
