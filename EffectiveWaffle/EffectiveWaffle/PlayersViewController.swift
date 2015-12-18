//
//  PlayersViewController.swift
//  EffectiveWaffle
//
//  Created by Ariel Rodriguez on 12/15/15.
//  Copyright © 2015 Ariel Rodriguez. All rights reserved.
//

import UIKit

class PlayerContainer: UIView, YouTubePlayerDelegate {
    let player: YouTubePlayerView!
    var autoplay = false
    
    required init?(coder aDecoder: NSCoder) {
        self.player = YouTubePlayerView(frame: CGRectZero)
        
        super.init(coder: aDecoder)
        
        self.player.translatesAutoresizingMaskIntoConstraints = false
        self.player.delegate = self
        
        self.addSubview(self.player)
        
        let pwc = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.player, attribute: NSLayoutAttribute.Width, multiplier: 1.0, constant: 0.0)
        self.addConstraint(pwc)
        
        let pxc = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.player, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)
        self.addConstraint(pxc)
        
        let ptc = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.player, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0.0)
        self.addConstraint(ptc)
        
        let pbc = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.player, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 30.0)
        self.addConstraint(pbc)
    }
    
    // MARK: YouTubePlayerDelegate
    func playerReady(videoPlayer: YouTubePlayerView) {
        if self.autoplay {
            self.player.play()
        }
    }
    
    func playerStateChanged(videoPlayer: YouTubePlayerView, playerState: YouTubePlayerState) {
        
    }
    
    func playerQualityChanged(videoPlayer: YouTubePlayerView, playbackQuality: YouTubePlaybackQuality) {
        
    }
}

class PlayersViewController: UIViewController {

    @IBOutlet var players: [PlayerContainer]!
    
    var videoId:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.videoId == nil {
            self.videoId = "lc14Jv1eTUE"
        }
        
        self.players.first!.player.loadVideoID(self.videoId)
        self.players.first!.autoplay = true
        self.players.last!.player.loadVideoID("FgnE25-kvyk")
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
