//
//  PlayersViewController.swift
//  EffectiveWaffle
//
//  Created by Ariel Rodriguez on 12/15/15.
//  Copyright © 2015 Ariel Rodriguez. All rights reserved.
//

import UIKit

class PlayerContainer: UIView, YouTubePlayerDelegate {
    let player: YouTubePlayerView
    var autoplay = false
    let playButton:UIButton
    let stopButton:UIButton
    
    required init?(coder aDecoder: NSCoder) {
        self.player = YouTubePlayerView(frame: CGRectZero)
        self.playButton = UIButton(type: UIButtonType.System)
        self.stopButton = UIButton(type: UIButtonType.System)
        
        super.init(coder: aDecoder)
        
        self.player.translatesAutoresizingMaskIntoConstraints = false
        self.player.delegate = self
        
        self.playButton.setTitle(NSLocalizedString("Play", comment: "Play"), forState: UIControlState.Normal)
        self.playButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.playButton.addTarget(self, action: Selector("play"), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.stopButton.setTitle(NSLocalizedString("Stop", comment: "Stop"), forState: UIControlState.Normal)
        self.stopButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.stopButton.addTarget(self, action: Selector("stop"), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.addSubview(self.player)
        self.addSubview(self.playButton)
        self.addSubview(self.stopButton)
        
        let pwc = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.player, attribute: NSLayoutAttribute.Width, multiplier: 1.0, constant: 0.0)
        self.addConstraint(pwc)
        
        let pxc = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.player, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)
        self.addConstraint(pxc)
        
        let ptc = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.player, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0.0)
        self.addConstraint(ptc)
        
        let pbc = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.player, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 30.0)
        self.addConstraint(pbc)
        
        let pbbc = NSLayoutConstraint(item: self.playButton, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0.0)
        self.addConstraint(pbbc)
        
        let pbxc = NSLayoutConstraint(item: self.playButton, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: -4.0)
        self.addConstraint(pbxc)
        
        let sbbc = NSLayoutConstraint(item: self.stopButton, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0.0)
        self.addConstraint(sbbc)
        
        let sbxc = NSLayoutConstraint(item: self.playButton, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self.stopButton, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: -8.0)
        self.addConstraint(sbxc)
    }
    
    // MARK: YouTubePlayerDelegate
    func playerReady(videoPlayer: YouTubePlayerView) {
        if self.autoplay {
            self.player.play()
        }
    }
    
    func playerStateChanged(videoPlayer: YouTubePlayerView, playerState: YouTubePlayerState) {
        NSNotificationCenter.defaultCenter().postNotificationName(Constants.Notification.PlayerStateDidChange, object: self)
    }
    
    func playerQualityChanged(videoPlayer: YouTubePlayerView, playbackQuality: YouTubePlaybackQuality) {
        
    }
    
    func play() {
        var title:String
        if self.player.playerState == YouTubePlayerState.Playing {
            title = NSLocalizedString("Play", comment: "Play")
            self.player.pause()
        } else {
            title = NSLocalizedString("Pause", comment: "Pause")
            self.player.play()
        }
        self.playButton.setTitle(title, forState: UIControlState.Normal)
    }
    
    func stop() {
        self.player.stop()
    }
}

class PlayersViewController: UIViewController {

    @IBOutlet var players: [PlayerContainer]!
    
    private var playerStateChangedObserver:NSObjectProtocol!
    
    var videoId:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.videoId == nil {
            self.videoId = "lc14Jv1eTUE"
        }
        
        self.players.first!.player.loadVideoID(self.videoId)
        self.players.first!.autoplay = true
        self.players.last!.player.loadVideoID("FgnE25-kvyk")
        
        self.playerStateChangedObserver = NSNotificationCenter.defaultCenter().addObserverForName(Constants.Notification.PlayerStateDidChange, object: nil, queue: NSOperationQueue.mainQueue(), usingBlock: { (n:NSNotification) -> Void in
            let o = n.object as! PlayerContainer
            for p in self.players {
                if p.player.playerState == YouTubePlayerState.Playing && p != o {
                    p.player.stop()
                }
            }
        })
    }
    
    deinit {
        if let p = playerStateChangedObserver {
            NSNotificationCenter.defaultCenter().removeObserver(p)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        for pc in self.players {
            if pc.player.playerState == YouTubePlayerState.Paused {
                pc.player.play()
            }
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        for pc in self.players {
            if pc.player.playerState == YouTubePlayerState.Playing {
                pc.player.pause()
            }
        }
    }
}
