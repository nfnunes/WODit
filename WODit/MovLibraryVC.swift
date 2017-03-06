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
   //     self.hideKeyboardWhenTappedAround()

        movSearchBar.delegate = self
        movTableView.dataSource = self
        movTableView.delegate = self
        
        let path = Bundle.main.path(forResource: "MOVs", ofType: "json")
        let jsonData = NSData(contentsOfFile: path!) as Data!
        let readableJSON = JSON(data: jsonData!)
        
        for (_,subJson):(String,JSON) in readableJSON{
            let name = subJson["name"].string
            
            let url = subJson["url"].string
            
            movs.append(EXERCISE(name: name!, url: url! ))
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "movCell", for: indexPath) as? MovCell{
            
            let mov: EXERCISE!
            
            if inSearchMode {
                mov = filteredMovs[indexPath.row]
                cell.updateUI(mov: mov)
            }
            else{
                mov = movs[indexPath.row]
                cell.updateUI(mov: mov)
            }
            
            cell.tapAction = { (cell) in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
               
                    let vc = storyboard.instantiateViewController(withIdentifier: "movVideoVC") as! movVideoVC
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if inSearchMode{
            return filteredMovs.count
        }
        else{
            return movs.count
        }
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
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

    @IBAction func goTimersBtnPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Timers", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Timers") as UIViewController
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func goTimersBtnPressed2(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Timers", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Timers") as UIViewController
        present(vc, animated: true, completion: nil)
    }


}
