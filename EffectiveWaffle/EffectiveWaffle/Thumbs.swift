//
//  Thumbs.swift
//  EffectiveWaffle
//
//  Created by Ariel Rodriguez on 12/14/15.
//  Copyright © 2015 Ariel Rodriguez. All rights reserved.
//

import Foundation

enum ThumbnailType {
    case Default
    case Medium
    case High
}

struct Thumbnail {
    let thumbType:ThumbnailType
    let url:NSURL
}