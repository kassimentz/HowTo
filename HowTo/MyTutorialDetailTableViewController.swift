//
//  MyTutorialDetailTableViewController.swift
//  HowTo
//
//  Created by Manuela Tarouco on 10/12/16.
//  Copyright © 2016 HowTo. All rights reserved.
//

import UIKit

protocol MyTutorialDetailTableViewControllerDelegate:class {
    func didAdd(tutorial:Tutorial)
    func didEdit(tutorial:Tutorial)
}

class MyTutorialDetailTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, StepsTableViewCellDelegate, MyTutorialDetailTableViewCellDelegate, NewStepViewControllerDelegate {

    var tutorial: Tutorial?
    var isEditingTutorial: Bool = false
    var currentTextView:UITextView?
    
    weak var delegate: MyTutorialDetailTableViewControllerDelegate?
    
    @IBOutlet weak var activeText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleTableView()
        
        if tutorial == nil {
            tutorial = Tutorial()
            tutorial?.steps = [Step]()
            self.title = "Novo Tutorial"
        } else {
            self.title = "Editar Tutorial"
            loadData()
        }
    }
    
    // MARK: - Style
    
    func styleTableView() {
        tableView.estimatedRowHeight = 200
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.separatorColor = UIColor.groupTableViewBackground
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - Load Data
    
    func loadData() {
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
    
    // MARK: - Table view data source

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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let tutorialCell: MyTutorialDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "myTutorialDetailCell", for: indexPath) as! MyTutorialDetailTableViewCell
            
            tutorialCell.titleText?.text = tutorial?.title
            tutorialCell.descricaoText.text = tutorial?.textDescription
            
            if let image = tutorial?.image {
                tutorialCell.pickedImage.image = image
            }
            
            tutorialCell.delegate = self
            
            return tutorialCell
        } else {
            let stepsCell: StepsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "myStepsTutorialDetailCell", for: indexPath) as! StepsTableViewCell
            
            if let step = tutorial?.steps?[indexPath.row] {
                stepsCell.stepsTitleDetail?.text = "Passo \(indexPath.row+1)"
                stepsCell.stepsDescriptionDetail?.text = step.text
                stepsCell.stepsImageDetail?.image = step.image
                
                stepsCell.step = step
                stepsCell.delegate = self
            }
            
            return stepsCell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let step = (tutorial?.steps?[indexPath.row])!
            performSegue(withIdentifier: "showNovoPasso", sender: step)
        }
    }
    
    // MARK: - Actions
 
    @IBAction func galeriaButtonAction(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Adicionar Foto", message: "Por favor, selecione uma opção", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Câmera", style: .default , handler:{ (UIAlertAction)in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Galeria", style: .default , handler:{ (UIAlertAction)in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
                imagePicker.allowsEditing = true
                self.present(imagePicker, animated: true, completion: nil)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: {
        })
    }
    
    @IBAction func salvarButtonAction(_ sender: UIBarButtonItem) {
        //TODO: Show loading overlay
        if let tut = tutorial {
            DataManager.save(tutorial: tut) { (result) in
                //TODO: Hide loading overlay
                if result == true {
                    if self.isEditingTutorial == true {
                        self.delegate?.didEdit(tutorial: tut)
                    } else {
                        self.delegate?.didAdd(tutorial: tut)
                    }
                    _ = self.navigationController?.popViewController(animated: true)
                } else {
                    //TODO:Show error
                }
            }
        }
    }
    
    @IBAction func novoPassoButtonAction(_ sender: UIButton) {
        performSegue(withIdentifier: "showNovoPasso", sender: sender)
    }
    
    // MARK: - Picker Controller
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        tutorial?.image = image
        self.dismiss(animated: true, completion: nil)
        tableView.reloadData()
    }
    
    // MARK: - StepsTableViewCellDelegate
    
    func removeStep(step: Step) {
        if let index = tutorial?.steps?.index(of: step) {
            tutorial?.steps?.remove(at: index)
            tableView.reloadData()
        }
    }
    
    // MARK: - MyTutorialDetailTableViewCellDelegate
    
    func didEdit(title: String) {
        tutorial?.title = title
        tableView.reloadData()
    }
    
    func didEdit(description: String) {
        tutorial?.textDescription = description
        tableView.reloadData()
    }
    
    // MARK: - NewStepViewControllerDelegate
    
    func didAdd(step: Step) {
        step.order = tutorial?.steps?.count ?? 0
        tutorial?.steps?.append(step)
        tableView.reloadData()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNovoPasso" {
            if let viewController:NewStepViewController = segue.destination as? NewStepViewController {
                if let step:Step = sender as? Step {
                    viewController.step = step
                }
                viewController.delegate = self
            }
        }
    }

}
