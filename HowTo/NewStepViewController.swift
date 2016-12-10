//
//  NewStepViewController.swift
//  HowTo
//
//  Created by Kassiane Mentz on 10/12/16.
//  Copyright © 2016 HowTo. All rights reserved.
//

import UIKit
import MobileCoreServices
import AssetsLibrary

class NewStepViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate  {

    var controller = UIImagePickerController()
    var assetsLibrary = ALAssetsLibrary()
    
    @IBOutlet weak var StepDescriptionTextField: UITextField!
    @IBOutlet weak var SaveStepButton: UIButton!
    
    @IBAction func recordVideo(_ sender: Any) {
        
        // 1 Check if project runs on a device with camera available
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            // 2 Present UIImagePickerController to take video
            controller = UIImagePickerController()
            controller.sourceType = .camera
            controller.mediaTypes = [kUTTypeMovie as String]
            controller.delegate = self
            controller.videoMaximumDuration = 600.0 //maximum duration to 10 minutes
            controller.videoQuality = UIImagePickerControllerQualityType(rawValue: 0)!
            present(controller, animated: true, completion: nil)
        }
        else {
            print("Camera is not available")
        }
    }
    
    @IBAction func viewLibrary(_ sender: Any) {
        // Display Photo Library
        controller.sourceType = UIImagePickerControllerSourceType.photoLibrary
        controller.mediaTypes = [kUTTypeMovie as String]
        controller.delegate = self
        
        present(controller, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // 1
        let mediaType:AnyObject? = info[UIImagePickerControllerMediaType] as AnyObject?
        
        if let type:AnyObject = mediaType {
            if type is String {
                let stringType = type as! String
                if stringType == kUTTypeMovie as String {
                    let urlOfVideo = info[UIImagePickerControllerMediaURL] as? URL
                    if let url = urlOfVideo {
                        // 2
                        assetsLibrary.writeVideoAtPath(toSavedPhotosAlbum: url,
                                                       completionBlock: {(url: URL?, error: Error?) in
                                                        if let theError = error{
                                                            print("Error saving video = \(theError)")
                                                        }
                                                        else {
                                                            print("no errors happened")
                                                        }
                        })
                    }
                }
                
            }
        }
        
        // 3
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
