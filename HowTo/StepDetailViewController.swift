//
//  StepDetailViewController.swift
//  HowTo
//
//  Created by Manuela Tarouco on 26/11/16.
//  Copyright © 2016 HowTo. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class StepDetailViewController: UIViewController {

    @IBOutlet weak var viewVideo: UIView!
    @IBOutlet weak var labelDescriptionVideo: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var backButtonImage: UIImageView!
    @IBOutlet weak var nextButtonImage: UIImageView!

    var player:AVPlayer?
    var steps:[Steps]?
    var stepCurrent:Int = 0 {
        didSet {
            updateViews()
        }
    }
    
    // MARK - View Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        updateViews()
    }
    
    override func viewDidLayoutSubviews() {
        loadVideo()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        player?.pause()
    }
    
    // MARK - Update Views
    
    func updateViews() {
        self.title = "Passo \(stepCurrent+1)/\(steps?.count ?? 0)"
        
        if progressView != nil {
            let fractionalProgress = Float(stepCurrent+1) / Float((steps?.count)!)
            progressView.setProgress(fractionalProgress, animated: true)
        }
        
        if labelDescriptionVideo != nil {
            labelDescriptionVideo.text = steps?[stepCurrent].text
        }
        
        if viewVideo != nil && player != nil {
            player?.pause()
            
            if let url = steps?[stepCurrent].videoURL {
                player = AVPlayer(url: url)
                player?.play()
            }
        }
        
        if backButtonImage != nil {
            backButtonImage.alpha = stepCurrent == 0 ? 0.2 : 1
        }
        
        if nextButtonImage != nil {
            nextButtonImage.alpha = stepCurrent+1 == steps?.count ? 0.2 : 1
        }
    }
    
    // MARK - Player
    
    func loadVideo() {
        if let url = steps?[stepCurrent].videoURL {
            player = AVPlayer(url: url)
            
            let blurPlayerLayer = AVPlayerLayer(player: player)
            blurPlayerLayer.frame = viewVideo.bounds
            blurPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill

            viewVideo.layer.addSublayer(blurPlayerLayer)
            
            let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.dark)) as UIVisualEffectView
            visualEffectView.frame = viewVideo.bounds
            viewVideo.addSubview(visualEffectView)
            
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = viewVideo.bounds
            viewVideo.layer.addSublayer(playerLayer)

            player?.play()
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil, queue: nil) { notification in
                self.player?.seek(to: kCMTimeZero)
                self.player?.play()
            }
        }
    }
    
    // MARK - Actions
    
    @IBAction func btnActionVideo(_ sender: AnyObject) {
        if player?.timeControlStatus == AVPlayerTimeControlStatus.playing {
            player?.pause()
        } else {
            player?.play()
        }
    }
    
    @IBAction func btnBack(_ sender: AnyObject) {
        if stepCurrent - 1 >= 0
        {
            stepCurrent = stepCurrent - 1
        }
    }

    @IBAction func btnNext(_ sender: AnyObject) {
        if stepCurrent + 1 < (steps?.count ?? 0)
        {
            stepCurrent = stepCurrent + 1
        }
    }
}
