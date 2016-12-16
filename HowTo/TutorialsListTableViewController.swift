//
//  TutorialsListTableViewController.swift
//  HowTo
//
//  Created by Kassiane Mentz on 26/11/16.
//  Copyright © 2016 HowTo. All rights reserved.
//

import UIKit

class TutorialsListTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchBarTopConstraint: NSLayoutConstraint!
    var refreshControl: UIRefreshControl!

    var tutorials:[Tutorial]?
    var filteredTutorials:[Tutorial]?
    var isShowing:Bool = false
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
                
        styleTableView()
        styleSearchBar()
        styleRefreshControl()
        
        //TODO: Show loading overlay
        populateTutorialsList()
    }
    
    // MARK: - Style
    
    func styleRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(TutorialsListTableViewController.populateTutorialsList), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func styleSearchBar() {
        searchBar.placeholder = "Pesquise por tutoriais"
        searchBar.delegate = self
    }
    
    func styleTableView() {
        tableView.estimatedRowHeight = 200
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - Fetch
    
    func populateTutorialsList() {
        DataManager.fetchTutorials { (success, tutorials) in
            self.refreshControl.endRefreshing()
            //TODO: hide loading overlay
            if success {
                self.tutorials = tutorials
                self.tableView.reloadData()
            } else {
                //TODO: Show error message
            }
        }
    }
    
    // MARK: - Actions

    @IBAction func didTapSearchButton(_ sender: Any) {
        searchBarTopConstraint.constant = isShowing ? -44 : 0
        isShowing = !isShowing
        
        if !isShowing {
            searchBar.text = nil
            filterContentForSearchText()
            searchBar.resignFirstResponder()
        } else {
            searchBar.becomeFirstResponder()
        }

        UIView.animate(withDuration:0.5, animations: {
            self.view.layoutIfNeeded()
        })
    }

    // MARK: - TableView

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tutorialArray()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TutorialCellTableViewCell = tableView.dequeueReusableCell(withIdentifier: "tutorialCell", for: indexPath) as! TutorialCellTableViewCell
        
        let tutorial:Tutorial? = tutorialArray()?[indexPath.row]
        
        cell.tutorialDescriptionComponent?.text = tutorial?.title
        cell.tutorialVideoComponent?.image = tutorial?.image ?? UIImage(named: "video-tutorial")
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tutorial:Tutorial? = tutorialArray()?[indexPath.row]
        performSegue(withIdentifier: "showTutorialDetail", sender: tutorial)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    // MARK: - UISearchBar Delegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterContentForSearchText()
    }
    
    // MARK: - Helper Methods
    
    func filterContentForSearchText() {
        let searchText:String = searchBar.text ?? ""
        filteredTutorials = tutorials?.filter({(tutorial : Tutorial) -> Bool in
            return (tutorial.title?.lowercased().contains(searchText.lowercased()))!
        })
        tableView.reloadData()
    }
    
    func tutorialArray() -> [Tutorial]? {
        if searchBar.text != "" {
            return filteredTutorials
        } else {
            return tutorials
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTutorialDetail" {
            let tutorialDetail = segue.destination as! TutorialDetailTableViewController
            if let tutorial = sender as? Tutorial {
                tutorialDetail.tutorial  = tutorial
            }
        }
    }
}
