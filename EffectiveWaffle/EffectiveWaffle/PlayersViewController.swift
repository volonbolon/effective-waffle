//
//  PlayersViewController.swift
//  EffectiveWaffle
//
//  Created by Ariel Rodriguez on 12/15/15.
//  Copyright © 2015 Ariel Rodriguez. All rights reserved.
//

import UIKit

class PlayersViewController: UIViewController {

    @IBOutlet weak var player: YouTubePlayerView!
    @IBOutlet weak var playButton: UIButton!
    var videoId:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.videoId == nil {
            self.videoId = "bDLyPmx439Y"
        }
        player.loadVideoID(self.videoId)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func resetPlayButton() {
        let playTitle = NSLocalizedString("Play", comment: "Play")
        self.playButton.setTitle(playTitle, forState: UIControlState.Normal)
    }
    
    @IBAction func play(sender: AnyObject) {
        if self.player.playerState == YouTubePlayerState.Playing {
            self.player.pause()
            self.resetPlayButton()
        } else {
            self.player.play()
            let pauseTitle = NSLocalizedString("Pause", comment: "Pause")
            self.playButton.setTitle(pauseTitle, forState: UIControlState.Normal)
        }
    }

    @IBAction func stop(sender: AnyObject) {
        self.resetPlayButton()
        self.player.stop()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
