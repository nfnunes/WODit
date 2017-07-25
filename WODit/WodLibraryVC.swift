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
    
    
    @IBOutlet weak var wodTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    // Filter buttons
    @IBOutlet weak var allBtn: UIButton!
    @IBOutlet weak var girlsBtn: UIButton!
    @IBOutlet weak var heroesBtn: UIButton!
    

    var expandedCells = [IndexPath]()
    var wods = [WOD]()
    var scoresWod = [String]()
    var exercisesWod = [String]()
    var selectedCellIndexPath: IndexPath?
    
    var inSearchMode = false

    var filteredWods = [WOD]()
    var shouldShowSearchResults = false
    
    var girlsSelected = false
    var girlsWods = [WOD]()
    
    var heroesSelected = false
    var heroesWods = [WOD]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        wodTableView.delegate = self
        wodTableView.dataSource = self
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

            // All WODs
            wods.append(WOD(name: name!, score: scoresWod, exercise: exercisesWod, timer: timer!, time: time! ))
        
            // WODs of type Girl
            if (subJson["type"].string == "Girls"){
                
                girlsWods.append(WOD(name: name!, score: scoresWod, exercise: exercisesWod, timer: timer!, time: time! ))
            }
            
            // WODs of type Heroe
            if (subJson["type"].string == "Heroes"){
                
                heroesWods.append(WOD(name: name!, score: scoresWod, exercise: exercisesWod, timer: timer!, time: time! ))
            }
            
            self.wodTableView.rowHeight = UITableViewAutomaticDimension
            self.wodTableView.estimatedRowHeight = 55
       
            scoresWod.removeAll()
            exercisesWod.removeAll()
        }
        allBtn.isSelected = true
    }
    
    // Check if a row of the tableview was selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Check if indexPath is already in the array of expanded rows
        if expandedCells.contains(indexPath){
            //remove from array
            expandedCells.remove(at: expandedCells.index(of: indexPath)!)
        } else {
            // append to array
            expandedCells.append(indexPath)
        }
        
        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
    }
    
    // Fill the WODs tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // if row must be shown expanded
        if expandedCells.contains(indexPath) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "wodCellExpanded", for: indexPath) as! WodCell
            
            let wod: WOD!
            
            if inSearchMode {
                wod = filteredWods[indexPath.row]
            }
            else if girlsSelected{
                wod = girlsWods[indexPath.row]
            }
            else if heroesSelected{
                wod = heroesWods[indexPath.row]
            }
            else{
                wod = wods[indexPath.row]
            }
            cell.updateUI(wod: wod)
            
            //When Go button is pressed:
            cell.tapAction = { (cell) in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                //For Time WOD
                if wod.timer == "For Time"{
                    let vc = storyboard.instantiateViewController(withIdentifier: "WODForTime") as! GoWODForTimeVC
                    self.present(vc, animated: true, completion: {
                        vc.WodName = wod.name
                        for item in wod.exercise{
                            vc.WodExercises = vc.WodExercises + item + "\r\n"
                        }
                        vc.SetupView()
                    })
                }
                //AMRAP WOD
                else if wod.timer == "AMRAP"{
                    let vc = storyboard.instantiateViewController(withIdentifier: "WODAmrap") as! GoWODAmrapVC
                    self.present(vc, animated: true, completion: {
                        vc.WodName = wod.name
                        for item in wod.exercise{
                            vc.WodExercises = vc.WodExercises + item + "\r\n"
                        }
                        vc.CurrentTime = wod.time
                        vc.SetupView()
                    })
                }
                //EMOM WOD
                else if wod.timer == "EMOM"{
                    let vc = storyboard.instantiateViewController(withIdentifier: "WODEmom") as! GoWodEmomVC
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
            
            // If row is collapsed
            else{
            let expandableCell = tableView.dequeueReusableCell(withIdentifier: "wodCell", for: indexPath) as! WodCell
            
            let wod: WOD!
            
            if inSearchMode {
                wod = filteredWods[indexPath.row]
            }
            else if girlsSelected{
                wod = girlsWods[indexPath.row]
            }
            else if heroesSelected{
                wod = heroesWods[indexPath.row]
            }
            else{
                wod = wods[indexPath.row]
            }
            expandableCell.updateUI(wod: wod)
            
            //When Go button is pressed
            expandableCell.tapAction = { (cell) in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                // For Time WOD
                if wod.timer == "For Time"{
                    let vc = storyboard.instantiateViewController(withIdentifier: "WODForTime") as! GoWODForTimeVC
                    self.present(vc, animated: true, completion: {
                        vc.WodName = wod.name
                        for item in wod.exercise{
                            vc.WodExercises = vc.WodExercises + item + "\r\n"
                        }
                        vc.SetupView()
                    })
                }
                //AMRAP WOD
                else if wod.timer == "AMRAP"{
                    let vc = storyboard.instantiateViewController(withIdentifier: "WODAmrap") as! GoWODAmrapVC
                    self.present(vc, animated: true, completion: {
                        vc.WodName = wod.name
                        for item in wod.exercise{
                            vc.WodExercises = vc.WodExercises + item + "\r\n"
                        }
                        vc.CurrentTime = wod.time
                        vc.SetupView()
                    })
                }
                // EMOM WOD
                else if wod.timer == "EMOM"{
                    let vc = storyboard.instantiateViewController(withIdentifier: "WODEmom") as! GoWodEmomVC
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
            return expandableCell
            }
    }
    
    // Set number of rows of the tableview
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
    
    // Set the number of sections of the tableview
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
 
    // Search for a WOD name
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            wodTableView.reloadData()
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
            wodTableView.reloadData()
        }
        
    }

    @IBAction func selectAllBtn(_ sender: Any) {
        
        allBtn.isSelected = true
        girlsBtn.isSelected = false
        heroesBtn.isSelected = false
        
        girlsSelected = false
        heroesSelected = false
        wodTableView.reloadData()
    }
    
    @IBAction func selectGirlsBtn(_ sender: Any) {
        
        allBtn.isSelected = false
        girlsBtn.isSelected = true
        heroesBtn.isSelected = false
        
        girlsSelected = true
        heroesSelected = false
        wodTableView.reloadData()
    }
    
    @IBAction func selectHeroesBtn(_ sender: Any) {
        
        allBtn.isSelected = false
        girlsBtn.isSelected = false
        heroesBtn.isSelected = true
        
        girlsSelected = false
        heroesSelected = true
        wodTableView.reloadData()
    }

}
