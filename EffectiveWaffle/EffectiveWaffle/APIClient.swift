//
//  APIClient.swift
//  EffectiveWaffle
//
//  Created by Ariel Rodriguez on 12/14/15.
//  Copyright © 2015 Ariel Rodriguez. All rights reserved.
//

import Foundation

enum APIClientError:ErrorType {
    case Reachability
    case Parse
    case BadURL
}

struct APIClient {
    static let POST = "POST"
    static let GET = "GET"
    static let DELETE = "DELETE"
    
    static let rootURL = "https://www.googleapis.com/youtube/v3"
    
    func requestWithURL(url:NSURL) -> NSMutableURLRequest {
        let urlRequest = NSMutableURLRequest(URL: url)
        // TODO: Here we can add headers
        return urlRequest
    }
}

extension APIClient {
    func getChannelInfo(channelName:String, completionHandler:(Either<Channel,APIClientError>)->Void) {
        let escapedChannelName = channelName.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())
        let urlString = "\(APIClient.rootURL)/channels?part=contentDetails,snippet&forUsername=\(escapedChannelName!)&key=\(Constants.APIKey.YouTube)"
        let url = NSURL(string: urlString)
        let request = self.requestWithURL(url!)
        request.HTTPMethod = APIClient.GET
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (d:NSData?, r:NSURLResponse?, e:NSError?) -> Void in
            var r:Either<Channel,APIClientError>!
            if e == nil {
                do {
                    let parsedResponse = try NSJSONSerialization.JSONObjectWithData(d!, options: NSJSONReadingOptions.AllowFragments) as! [String:AnyObject]
                    let rawItems = parsedResponse["items"] as? [[String:AnyObject]]
                    
                    if rawItems != nil {
                        let c = Channel(rawData: rawItems!.first!)
                        r = Either.Left(c)
                    } else {
                        r = Either.Right(APIClientError.Parse)
                    }
                } catch {
                    r = Either.Right(APIClientError.Parse)
                }
            } else {
                r = Either.Right(APIClientError.Reachability)
            }
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                completionHandler(r)
            })
        }
        task.resume()
    }
}