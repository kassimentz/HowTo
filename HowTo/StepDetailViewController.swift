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
    var steps:[Steps]?
    var stepCurrent:Int?
    
    @IBOutlet weak var labelDescricaoVideo: UILabel!
    
    var player: AVPlayer?
    
    @IBOutlet weak var progressView: UIProgressView!
    
    var counter:Int = 0 {
        didSet {
            let fractionalProgress = Float(counter+1) / Float((steps?.count)!)
            let animated = counter+1 != 0
            
            progressView.setProgress(fractionalProgress, animated: animated)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        stepCurrent=0
        
        let step1 = Steps();
        step1.text = "TESTE VIDEO 1"
        step1.videoURL = "http://dev.exiv2.org/attachments/341/video-2012-07-05-02-29-27.mp4"
        
        let step2 = Steps();
        step2.text = "TESTE VIDEO 2"
        step2.videoURL = "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"
        
        let step3 = Steps();
        step3.text = "TESTE VIDEO 3"
        step3.videoURL = "http://dev.exiv2.org/attachments/345/04072012033.mp4"
        
        let step4 = Steps();
        step4.text = "TESTE VIDEO 4"
        step4.videoURL = "http://dev.exiv2.org/attachments/346/05112011034.mp4"
        
        steps = [step1, step2, step3, step4]
        
        // carrega dados dos steps
        labelDescricaoVideo.text = steps?[stepCurrent!].text
        

        progressView.setProgress(0, animated: true)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        carregaVideo()
        counter = stepCurrent!
    }
    
    
    func carregaVideo(){
        
        let videoURL = URL(string: (steps?[stepCurrent!].videoURL)!)
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
    

    @IBAction func btnBack(_ sender: AnyObject) {
        if stepCurrent!-1 >= 0
        {
            stepCurrent=stepCurrent!-1
            
            labelDescricaoVideo.text = steps?[stepCurrent!].text
            
            player?.pause()
            player = AVPlayer(url: URL(string: (steps?[stepCurrent!].videoURL)!)!)
            player?.play()
            
            counter=stepCurrent!
            
        }
    }

    @IBAction func btnNext(_ sender: AnyObject) {
        if stepCurrent!+1 < (steps?.count)!
        {
            stepCurrent=stepCurrent!+1
            
           labelDescricaoVideo.text = steps?[stepCurrent!].text
            
            player?.pause()
            player = AVPlayer(url: URL(string: (steps?[stepCurrent!].videoURL)!)!)
            player?.play()
            
            counter=stepCurrent!
        }
    }

}
