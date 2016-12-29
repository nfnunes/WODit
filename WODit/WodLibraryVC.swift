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
    
    var instanceOfForTimeVC = goWODForTimeVC()
    
    var wods = [WOD]()
    var scoresWod = [String]()
    var exercisesWod = [String]()
    var selectedCellIndexPath: IndexPath?
    
    @IBOutlet weak var wodtableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var inSearchMode = false
    
    //var wodSearchController: UISearchController!

    @IBOutlet weak var allBtn: UIButton!
    @IBOutlet weak var girlsBtn: UIButton!
    @IBOutlet weak var heroesBtn: UIButton!
    
    var filteredWods = [WOD]()
    var shouldShowSearchResults = false
    
    var girlsSelected = false
    var girlsWods = [WOD]()
    
    var heroesSelected = false
    var heroesWods = [WOD]()

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
            
            let timer = subJson["timer"].string
            let time = subJson["time"].int

            wods.append(WOD(name: name!, score: scoresWod, exercise: exercisesWod, timer: timer!, time: time! ))
        
            if (subJson["type"].string == "Girls"){
                
                girlsWods.append(WOD(name: name!, score: scoresWod, exercise: exercisesWod, timer: timer!, time: time! ))
                
            }
            
            if (subJson["type"].string == "Heroes"){
                
                heroesWods.append(WOD(name: name!, score: scoresWod, exercise: exercisesWod, timer: timer!, time: time! ))
                
            }
       
            scoresWod.removeAll()
            exercisesWod.removeAll()
        }
       // wodtableView.rowHeight = UITableViewAutomaticDimension
        
        allBtn.isSelected = true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "wodCell", for: indexPath) as? WodCell{
            
            let wod: WOD!
            
            if inSearchMode {
                wod = filteredWods[indexPath.row]
                cell.updateUI(wod: wod)
                
            }
            else if girlsSelected{
                wod = girlsWods[indexPath.row]
                cell.updateUI(wod: wod)
            }
            else if heroesSelected{
                wod = heroesWods[indexPath.row]
                cell.updateUI(wod: wod)
            }
            else{
                wod = wods[indexPath.row]
                cell.updateUI(wod: wod)
            }
            
            cell.tapAction = { (cell) in
                print(wod.timer)
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if wod.timer == "For Time"{
                    let vc = storyboard.instantiateViewController(withIdentifier: "WODForTime") as! goWODForTimeVC
                    self.present(vc, animated: true, completion: {
                        vc.WodName = wod.name
                        for item in wod.exercise{
                            vc.WodExercises = vc.WodExercises + item + "\r\n"
                        }
                        vc.SetupView()
                    })
                }
                else if wod.timer == "AMRAP"{
                    let vc = storyboard.instantiateViewController(withIdentifier: "WODAmrap") as! goWODAmrapVC
                    self.present(vc, animated: true, completion: {
                        vc.WodName = wod.name
                        for item in wod.exercise{
                            vc.WodExercises = vc.WodExercises + item + "\r\n"
                        }
                        vc.CurrentTime = wod.time
                        vc.SetupView()
                    })
                }
                
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
        else if girlsSelected{
            return girlsWods.count
        }
        else if heroesSelected{
            return heroesWods.count
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
            if !girlsSelected && !heroesSelected{
                filteredWods = wods.filter({$0.name.lowercased().range(of: entry) != nil })
            }
            else if girlsSelected{
                filteredWods = girlsWods.filter({$0.name.lowercased().range(of: entry) != nil })
            }
            else if heroesSelected{
                filteredWods = heroesWods.filter({$0.name.lowercased().range(of: entry) != nil })
            }
            
            wodtableView.reloadData()
        }
        
    }
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func selectAllBtn(_ sender: Any) {
        
        allBtn.isSelected = true
        girlsBtn.isSelected = false
        heroesBtn.isSelected = false
        
        girlsSelected = false
        heroesSelected = false
        wodtableView.reloadData()
    }
    
    @IBAction func selectGirlsBtn(_ sender: Any) {
        
        allBtn.isSelected = false
        girlsBtn.isSelected = true
        heroesBtn.isSelected = false
        
        girlsSelected = true
        heroesSelected = false
        wodtableView.reloadData()
    }
    
    @IBAction func selectHeroesBtn(_ sender: Any) {
        
        allBtn.isSelected = false
        girlsBtn.isSelected = false
        heroesBtn.isSelected = true
        
        girlsSelected = false
        heroesSelected = true
        wodtableView.reloadData()
    }
    
    @IBAction func goTimersBtnPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Timers", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Timers") as UIViewController
        present(vc, animated: true, completion: nil)
    }

}
