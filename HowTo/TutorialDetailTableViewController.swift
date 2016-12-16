//
//  TutorialDetailTableViewController.swift
//  HowTo
//
//  Created by Kassiane Mentz on 03/12/16.
//  Copyright © 2016 HowTo. All rights reserved.
//

import UIKit

class TutorialDetailTableViewController: UITableViewController {
    
    var tutorial: Tutorial?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tableView.estimatedRowHeight = 200
    }
    
    // MARK: - Load Data
    
    func loadData() {
        
        if tutorial?.user == nil {
            DataManager.fetchUserForTutorial(tutorial: tutorial!, completionHandler: { (success, user) in
                if success {
                    self.tutorial?.user = user
                    self.tableView.reloadData()
                }
            })
        }
        
        if tutorial?.steps == nil {
            //TODO: show loading overlay
            DataManager.fetchStepsForTutorial(tutorial: tutorial!, completionHandler: { (success, steps) in
                //TODO: hide loading overlay
                if success {
                    self.tutorial?.steps = steps
                    self.tableView.reloadData()
                } else {
                    //TODO: show error
                }
            })
        }
    }

    // MARK: - TableView

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1;
        } else {
            return tutorial?.steps?.count ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let tutorialCell: TutorialDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "tutorialDetailCell", for: indexPath) as! TutorialDetailTableViewCell
            
            tutorialCell.descriptionTutorialDetail?.text = tutorial?.textDescription
            tutorialCell.titleTutorialDetail?.text = tutorial?.title
            tutorialCell.tutorialDetailImage?.image = tutorial?.image ?? UIImage(named: "video-tutorial")
            tutorialCell.userProfileDetailImage?.image = tutorial?.user?.image ?? UIImage(named: "User")
            return tutorialCell
        } else {
            let stepsCell: StepsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "stepsDetailCell", for: indexPath) as! StepsTableViewCell
            
            let step = (tutorial?.steps?[indexPath.row])!
            stepsCell.stepsTitleDetail?.text = "Passo \(indexPath.row+1)"
            stepsCell.stepsDescriptionDetail?.text = step.text
            stepsCell.stepsImageDetail?.image = step.image ?? UIImage(named: "video-tutorial")
            
            return stepsCell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            performSegue(withIdentifier: "stepDetailSegue", sender: indexPath.row)
        }
    }
    
    // MARK - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stepDetailSegue" {
            let viewController:StepDetailViewController = segue.destination as! StepDetailViewController
            viewController.steps = tutorial?.steps
            viewController.stepCurrent = sender as? Int ?? 0
        }
    }
}
