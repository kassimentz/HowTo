//
//  MyTutorialsTableViewController.swift
//  HowTo
//
//  Created by Kassiane Mentz on 03/12/16.
//  Copyright © 2016 HowTo. All rights reserved.
//

import UIKit

class MyTutorialsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MyTutorialDetailTableViewControllerDelegate {

    @IBOutlet weak var tableView: UITableView!

    var tutorials:[Tutorial] = [Tutorial]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleTableView()
        fetchData()
    }
    
    // MARK: - Style
    
    func styleTableView() {
        tableView.estimatedRowHeight = 200
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - Fetch Data
    
    func fetchData() {
        if Singleton.sharedInstance.isLoggingIn == true {
            //TODO: show loading overlay
            NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "DidChangeCurrentUser"), object: nil, queue: nil) { notification in
                self.fetchUserTutorials()
            }
        } else {
            self.fetchUserTutorials()
        }
    }
    
    func fetchUserTutorials() {
        
        //TODO: show loading overlay
        
        if let currentUser = Singleton.sharedInstance.currentUser {
            DataManager.fetchTutorialsForUser(user: currentUser, completionHandler: { (result, tutorials) in
                
                //TODO:Hide loading overlay
                
                if result == true {
                    self.tutorials = tutorials
                    self.tableView.reloadData()
                } else {
                    //TODO:show error message
                }
            })
        }
    }

    // MARK: - TableView

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tutorials.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MyTutorialTableViewCell = tableView.dequeueReusableCell(withIdentifier: "myTutorialsCell", for: indexPath) as! MyTutorialTableViewCell
        let tutorial = tutorials[indexPath.row]
        cell.myTutorialsTitle?.text = tutorial.title
        cell.myTutorialsDescription?.text = tutorial.textDescription
        cell.myTutorialsImage?.image = tutorial.image
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tutorial = tutorials[indexPath.row]
        performSegue(withIdentifier: "showMyTutorialDetail", sender: tutorial)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    // MARK: - MyTutorialDetailTableViewController
    
    func didAdd(tutorial:Tutorial) {
        tutorials.insert(tutorial, at: 0)
        tableView.reloadData()
    }
    
    func didEdit(tutorial:Tutorial) {
        let index = tutorials.index(of: tutorial)
        
        if let ind = index {
            tutorials.remove(at: ind)
            tutorials.insert(tutorial, at: 0)
        }
        tableView.reloadData()

    }
    
    // MARK: - Action
    
    @IBAction func newTutorial(_ sender: AnyObject) {
        performSegue(withIdentifier: "showMyTutorialDetail", sender: sender)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "showMyTutorialDetail" {
            let tutorialDetail = segue.destination as! MyTutorialDetailTableViewController
            tutorialDetail.delegate = self
            if let tutorial = sender as? Tutorial {
                tutorialDetail.tutorial  = tutorial
                tutorialDetail.isEditingTutorial = true
            }
        }
    }
}
