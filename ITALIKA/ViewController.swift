//
//  ViewController.swift
//  Video Background
//
//  Created by Kai Schaller on 3/11/15.
//  Copyright (c) 2015 Kai Schaller. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import TKSubmitTransition

class ViewController: UIViewController {
    
    var player: AVPlayer?
    @IBOutlet weak var ivFB: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the video from the app bundle.
        let videoURL: NSURL = NSBundle.mainBundle().URLForResource("videoRec", withExtension: "mov")!
        
        player = AVPlayer(URL: videoURL)
        player?.actionAtItemEnd = .None
        player?.muted = true
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayer.zPosition = -1
        
        playerLayer.frame = view.frame
        
        view.layer.addSublayer(playerLayer)
        
        player?.play()
        
        //loop video
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: "loopVideo",
                                                         name: AVPlayerItemDidPlayToEndTimeNotification,
                                                         object: nil)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        //let nv = self.storyboard?.instantiateViewControllerWithIdentifier("SWRevealViewController")
        //UIApplication.sharedApplication().keyWindow?.rootViewController = nv
    }
    
    func loopVideo() {
        player?.seekToTime(kCMTimeZero)
        player?.play()
    }
    
    
    @IBAction func loginFB(sender: TKTransitionSubmitButton) {
        sender.startLoadingAnimation()
        ivFB.hidden = true
        let loginManager:FBSDKLoginManager = FBSDKLoginManager()
        loginManager.logInWithReadPermissions(["public_profile","email","user_friends"], fromViewController: self, handler: { (result,error) -> Void in
            if((error) != nil){
                
            }else if result.isCancelled {
                sender.stopAnimation()
                self.ivFB.hidden = false
                print("Cancelo inicio de sesion")
            }else{
                User.currentUser.fbSignup({
                    sender.startFinishAnimation(1, completion: {
                        self.ivFB.hidden = false
                        let nv = self.storyboard?.instantiateViewControllerWithIdentifier("SWRevealViewController")
                        UIApplication.sharedApplication().keyWindow?.rootViewController = nv
                    })
                })
            }
        })
    }
    
    
    
    
    
    
}

