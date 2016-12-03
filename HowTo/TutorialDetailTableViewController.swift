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
    var steps:[Steps]?
    var user : User?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(tutorial?.steps == nil) {
            steps = [Steps]()
        } else {
            steps = tutorial?.steps
        }
        
        if(tutorial?.user == nil) {
            user = User()
        } else {
            user = tutorial?.user
        }
        
        tableView.estimatedRowHeight = 200

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0) {
            return 1;
        } else {
            return steps!.count
        }
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.section == 0) {
            let tutorialCell: TutorialDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "tutorialDetailCell", for: indexPath) as! TutorialDetailTableViewCell
            
            tutorialCell.descriptionTutorialDetail?.text = tutorial?.textDescription
            tutorialCell.titleTutorialDetail?.text = tutorial?.title
            tutorialCell.tutorialDetailImage?.image = tutorial?.image
            tutorialCell.userProfileDetailImage?.image = user?.profileImage
            return tutorialCell
        
        } else {
            
            let stepsCell: StepsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "stepsDetailCell", for: indexPath) as! StepsTableViewCell
            
            let step: Steps
            step = (steps?[indexPath.row])!
            
            stepsCell.stepsTitleDetail?.text = "Passo\(indexPath.row+1)"
            stepsCell.stepsDescriptionDetail?.text = step.text
            stepsCell.stepsImageDetail?.image = step.image
            
            return stepsCell
        }
        
    }
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
