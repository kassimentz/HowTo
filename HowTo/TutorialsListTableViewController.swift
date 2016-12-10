//
//  TutorialsListTableViewController.swift
//  HowTo
//
//  Created by Kassiane Mentz on 26/11/16.
//  Copyright © 2016 HowTo. All rights reserved.
//

import UIKit

class TutorialsListTableViewController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {
    
    
    // MARK: - Properties
    var tutorials = [Tutorial]()
    var filteredTutorials = [Tutorial]()
    let searchController = UISearchController(searchResultsController: nil)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        
        self.title = "Tutoriais"
        
        populateTutorialsList()
        
    }
    
    func populateTutorialsList(){
        tutorials = [
            Tutorial(title:"titulo1", textDescription: "textDescription1", image: #imageLiteral(resourceName: "Play Filled-100")),
            Tutorial(title:"titulo2", textDescription: "textDescription2", image: #imageLiteral(resourceName: "Play Filled-100")),
            Tutorial(title:"titulo3", textDescription: "textDescription3", image: #imageLiteral(resourceName: "Play Filled-100")),
            Tutorial(title:"titulo4", textDescription: "textDescription4", image: #imageLiteral(resourceName: "Play Filled-100")),
            Tutorial(title:"titulo5", textDescription: "textDescription5", image: #imageLiteral(resourceName: "Play Filled-100"))
        ]
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredTutorials.count
        }
        return tutorials.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TutorialCellTableViewCell = tableView.dequeueReusableCell(withIdentifier: "tutorialCell", for: indexPath) as! TutorialCellTableViewCell
        let tutorial: Tutorial
        if searchController.isActive && searchController.searchBar.text != "" {
            tutorial = filteredTutorials[indexPath.row]
        } else {
            tutorial = tutorials[indexPath.row]
        }
        
        cell.tutorialDescriptionComponent?.text = tutorial.title
        cell.tutorialVideoComponent?.image = tutorial.image
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tutorial: Tutorial
        if searchController.isActive && searchController.searchBar.text != "" {
            tutorial = filteredTutorials[indexPath.row]
        } else {
            tutorial = tutorials[indexPath.row]
        }
        performSegue(withIdentifier: "showTutorialDetail", sender: tutorial)
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredTutorials = tutorials.filter({( tutorial : Tutorial) -> Bool in
            return (tutorial.title?.lowercased().contains(searchText.lowercased()))!
        })
        tableView.reloadData()
    }
    
    // MARK: - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!)
    }
    
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showTutorialDetail" {
            let tutorialDetail = segue.destination as! TutorialDetailTableViewController
            if let tutorial = sender as? Tutorial {
                tutorialDetail.tutorial  = tutorial
            }
        }
    }
 

}
