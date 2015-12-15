//
//  Video.swift
//  EffectiveWaffle
//
//  Created by Ariel Rodriguez on 12/14/15.
//  Copyright © 2015 Ariel Rodriguez. All rights reserved.
//

import Foundation

struct Video {
    let name:String
    let videoInfo:String
    let thumbs:[Thumbnail]
    let videoId:String
    
    init(rawData:[String:AnyObject]) {
        let snippet = rawData["snippet"] as! [String:AnyObject]
        self.name = snippet["title"] as! String
        self.videoInfo = snippet["description"] as! String
        let rt = snippet["thumbnails"] as! [String:AnyObject]
        let rawDefault = rt["default"] as! [String:AnyObject]
        let url = NSURL(string: rawDefault["url"] as! String)
        let t = Thumbnail(thumbType:ThumbnailType.Default, url:url!)
        self.thumbs = [t]
        let resourceId = rawData["resourceId"] as! [String:AnyObject]
        let videoId = resourceId["videoId"] as! String
        self.videoId = videoId
    }
}