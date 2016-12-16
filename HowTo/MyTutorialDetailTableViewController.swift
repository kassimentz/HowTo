//
//  MyTutorialDetailTableViewController.swift
//  HowTo
//
//  Created by Manuela Tarouco on 10/12/16.
//  Copyright © 2016 HowTo. All rights reserved.
//

import UIKit

class MyTutorialDetailTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var tutorial: Tutorial?
    var newImage:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if tutorial == nil {
            self.title = "Novo Tutoriais"
        
        
        }else{
            self.title = "Tutoriais"
            
        }
        
        tableView.estimatedRowHeight = 200

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 1;
        } else {
        return tutorial?.steps?.count ?? 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.section == 0){
            let tutorialCell: MyTutorialDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "myTutorialDetailCell", for: indexPath) as! MyTutorialDetailTableViewCell
            
            tutorialCell.titleText?.text = tutorial?.title
            
            if let image = newImage {
                tutorialCell.pickedImage.image = image
            }
            
            return tutorialCell
            
        }else{
            
            let stepsCell: StepsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "myStepsTutorialDetailCell", for: indexPath) as! StepsTableViewCell
            
            let step: Steps
            step = (tutorial?.steps?[indexPath.row])!
            
            stepsCell.stepsTitleDetail?.text = "Passo\(indexPath.row+1)"
            stepsCell.stepsDescriptionDetail?.text = step.text
            stepsCell.stepsImageDetail?.image = step.image
            
            return stepsCell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showNovoPasso", sender: nil)
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

    
    // MARK: - Navigation
 
    
    @IBAction func cameraButtonAction(_ sender: UIButton) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func galeriaButtonAction(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
            
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        
        newImage = image
        self.dismiss(animated: true, completion: nil)
        
        tableView.reloadData()
        
    }
    
    
    @IBAction func salvarButtonAction(_ sender: UIBarButtonItem) {
        
        
    }
    
    
    @IBAction func novoPassoButtonAction(_ sender: UIButton) {
        performSegue(withIdentifier: "showNovoPasso", sender: sender)
    }

    
}
