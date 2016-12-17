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
import AVKit
import AVFoundation

protocol NewStepViewControllerDelegate:class {
    func didAdd(step:Step)
}

class NewStepViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate  {

    var controller = UIImagePickerController()
    var assetsLibrary = ALAssetsLibrary()
    var player:AVPlayer?
    var step:Step?
    
    weak var delegate: NewStepViewControllerDelegate!
    
    @IBOutlet weak var stepDescriptionText: UITextView!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var addVideoButton: UIButton!
    @IBOutlet weak var changeVideo: UIButton!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if step != nil {
            stepDescriptionText.text = step?.text
            if let videoURL = step?.videoURL {
                loadVideo(videoURL)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        player?.pause()
    }
    
    // MARK: - Keyboard
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - Video
    
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
    }
    
    func viewLibrary(_ sender: Any) {
        controller.sourceType = UIImagePickerControllerSourceType.photoLibrary
        controller.mediaTypes = [kUTTypeMovie as String]
        controller.delegate = self
        present(controller, animated: true, completion: nil)
    }
    
    func loadVideo(_ url: URL) {
        
        player = AVPlayer(url: url)
        
        let blurPlayerLayer = AVPlayerLayer(player: player)
        blurPlayerLayer.frame = videoView.bounds
        blurPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        videoView.layer.addSublayer(blurPlayerLayer)
        
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.dark)) as UIVisualEffectView
        visualEffectView.frame = videoView.bounds
        videoView.addSubview(visualEffectView)
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = videoView.bounds
        videoView.layer.addSublayer(playerLayer)
        
        player?.play()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil, queue: nil) { notification in
            self.player?.seek(to: kCMTimeZero)
            self.player?.play()
        }
    }
    
    // MARK: - Action

    @IBAction func showActionSheetButton(_ sender: Any) {
        let alert = UIAlertController(title: "Adicionar Vídeo", message: "Por favor, selecione uma opção", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Filmar Vídeo", style: .default , handler:{ (UIAlertAction)in
            self.recordVideo(sender)
        }))
        
        alert.addAction(UIAlertAction(title: "Escolher da Galeria", style: .default , handler:{ (UIAlertAction)in
            self.viewLibrary(sender)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion:nil)
    }
    
    @IBAction func stopPlayButton(_ sender: Any) {
        if player?.timeControlStatus == AVPlayerTimeControlStatus.playing {
            player?.pause()
        } else {
            player?.play()
        }
    }
    
    @IBAction func didTapSaveButton(_ sender: Any) {
        if (step == nil) {
            step = Step()
        }
        
        step?.text = stepDescriptionText.text
        delegate.didAdd(step: step!)
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapChangeButton(_ sender: Any) {
        showActionSheetButton(sender:sender)
    }
    
    // MARK: - Image Picker
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let mediaType:AnyObject? = info[UIImagePickerControllerMediaType] as AnyObject?
        
        if let type:AnyObject = mediaType {
            if type is String {
                let stringType = type as! String
                if stringType == kUTTypeMovie as String {
                    let urlOfVideo = info[UIImagePickerControllerMediaURL] as? URL
                    if let url = urlOfVideo {
                        
                        //create a step model object using this url.
                        
                        if step == nil {
                            step = Step();
                        }
                        
                        changeVideo.isHidden = false;
                        addVideoButton.isHidden = true;
                        
                        step?.text = stepDescriptionText.text!
                        step?.videoURL = url
                        loadVideo(url)
                        
                        assetsLibrary.writeVideoAtPath(toSavedPhotosAlbum: url,
                                                       completionBlock: {(url: URL?, error: Error?) in
                                                        if error != nil {
                                                            //TODO:Show Error
                                                        }
                        })
                    }
                }
                
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
