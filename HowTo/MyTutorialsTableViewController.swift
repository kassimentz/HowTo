//
//  MyTutorialsTableViewController.swift
//  HowTo
//
//  Created by Kassiane Mentz on 03/12/16.
//  Copyright © 2016 HowTo. All rights reserved.
//

import UIKit

class MyTutorialsTableViewController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {

    @IBOutlet var newTutorialButton: UITableView!
    
    
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
        
        
        self.title = "Meus Tutoriais"
        
        populateMyTutorialsList()
        
    }
    
    func populateMyTutorialsList() {
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
        let cell:MyTutorialTableViewCell = tableView.dequeueReusableCell(withIdentifier: "myTutorialsCell", for: indexPath) as! MyTutorialTableViewCell
        let tutorial: Tutorial
        if searchController.isActive && searchController.searchBar.text != "" {
            tutorial = filteredTutorials[indexPath.row]
        } else {
            tutorial = tutorials[indexPath.row]
        }
        
        cell.myTutorialsTitle?.text = tutorial.title
        cell.myTutorialsDescription?.text = tutorial.textDescription
        cell.myTutorialsImage?.image = tutorial.image
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tutorial: Tutorial
        if searchController.isActive && searchController.searchBar.text != "" {
            tutorial = filteredTutorials[indexPath.row]
        } else {
            tutorial = tutorials[indexPath.row]
        }
        performSegue(withIdentifier: "showMyTutorialDetail", sender: tutorial)
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
    // Usar quando a tableViewController de MyTutorial Detalhes estiver pronta
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showMyTutorialDetail" {
            let tutorialDetail = segue.destination as! MyTutorialDetailTableViewController
            if let tutorial = sender as? Tutorial {
                tutorialDetail.tutorial  = tutorial
            }
        }
    }
     */

}
