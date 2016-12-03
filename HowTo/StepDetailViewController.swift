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
    
    var player: AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        carregaVideo()
    }
    
    func carregaVideo(){
        
        let videoURL = URL(string: "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
        player = AVPlayer(url: videoURL!)
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = viewVideo.bounds
        
        viewVideo.layer.addSublayer(playerLayer)
        player?.play()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil, queue: nil) { notification in
            self.player?.seek(to: kCMTimeZero)
            self.player?.play()
        }
    }
    
    func playerItemDidReachEnd(notification: NSNotification) {
        player?.seek(to: kCMTimeZero)
        player?.play()
    }
    
    
    @IBAction func btnActionVideo(_ sender: AnyObject) {
        
        if player?.timeControlStatus == AVPlayerTimeControlStatus.playing
        {
            player?.pause()
        }else{
            player?.play()
        }
        
        
    }
    



}
