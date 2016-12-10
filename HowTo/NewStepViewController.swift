//
//  NewStepViewController.swift
//  HowTo
//
//  Created by Kassiane Mentz on 10/12/16.
//  Copyright © 2016 HowTo. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVKit
import AVFoundation

class NewStepViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    let imagePicker: UIImagePickerController! = UIImagePickerController()
    let saveFileName = "/test.mp4"
    
    @IBOutlet weak var StepDescriptionTextField: UITextField!
    @IBOutlet weak var SaveStepButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func recordVideo(_ sender: Any) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
     
     
    }
    */

}
