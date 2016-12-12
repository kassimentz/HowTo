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

class NewStepViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate  {

    var controller = UIImagePickerController()
    var assetsLibrary = ALAssetsLibrary()
    
    @IBOutlet weak var stepDescriptionText: UITextView!
    @IBOutlet weak var SaveStepButton: UIButton!
    
    
    func recordVideo(_ sender: Any) {
        
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
    
    
    func viewLibrary(_ sender: Any) {
        // Display Photo Library
        controller.sourceType = UIImagePickerControllerSourceType.photoLibrary
        controller.mediaTypes = [kUTTypeMovie as String]
        controller.delegate = self
        
        present(controller, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 
    }
    
    @IBAction func showActionSheetButton(_ sender: Any) {
        let alert = UIAlertController(title: "Adicionando Vídeo", message: "Por favor, selecione uma opção", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Filmar Vídeo", style: .default , handler:{ (UIAlertAction)in
            print("filmar video")
            self.recordVideo(sender)
        }))
        
        alert.addAction(UIAlertAction(title: "Escolher da Galeria", style: .default , handler:{ (UIAlertAction)in
            print("escolher da galeria")
            self.viewLibrary(sender)
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
        
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
                        
                        //create a step model object using this url.
                        let step1 = Steps();
                        step1.text = stepDescriptionText.text!
                        step1.videoURL = url
                        
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

//Extension to hide keyboard. just use hideKeyboardWhenTappedAround
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

