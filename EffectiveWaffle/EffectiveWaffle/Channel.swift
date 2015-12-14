//
//  Channel.swift
//  EffectiveWaffle
//
//  Created by Ariel Rodriguez on 12/14/15.
//  Copyright © 2015 Ariel Rodriguez. All rights reserved.
//

import Foundation

struct Channel {
    let name:String
    let channelInfo:String
    let thumbs:[Thumbnail]
    let playlistId:String
    
    init(rawData:[String:AnyObject]) {
        let snippet = rawData["snippet"] as! [String:AnyObject]
        self.name = snippet["title"] as! String
        self.channelInfo = snippet["description"] as! String
        let rt = snippet["thumbnails"] as! [String:AnyObject]
        let rawDefault = rt["default"] as! [String:AnyObject]
        let url = NSURL(string: rawDefault["url"] as! String)
        let t = Thumbnail(thumbType:ThumbnailType.Default, url:url!)
        self.thumbs = [t]
        let contentDetails = rawData["contentDetails"] as! [String:AnyObject]
        let relatedPlaylists = contentDetails["relatedPlaylists"] as! [String:AnyObject]
        let playlistId = relatedPlaylists["uploads"] as! String
        self.playlistId = playlistId
    }
}