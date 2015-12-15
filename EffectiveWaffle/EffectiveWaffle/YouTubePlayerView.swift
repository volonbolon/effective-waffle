//
//  YouTubePlayerView.swift
//  EffectiveWaffle
//
//  Created by Ariel Rodriguez on 12/15/15.
//  Copyright © 2015 Ariel Rodriguez. All rights reserved.
//

import UIKit
import WebKit
/*
public class YouTubePlayerView: UIView, WKScriptMessageHandler {
    private var webView:WKWebView!
    private var videoId:String!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.buildWebView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.buildWebView()
    }
    
    public func loadVideoId(videoId:String) {
        self.videoId = videoId
        self.loadHTML()
    }
    
    public func playVideo() {
        self.webView.evaluateJavaScript("playVideo()", completionHandler: nil)
    }
    
    public func pauseVideo() {
        self.webView.evaluateJavaScript("pauseVideo()", completionHandler: nil)
    }
    
    public func stopVideo() {
        self.webView.evaluateJavaScript("stopVideo()", completionHandler: nil)
    }
    
    func buildWebView() {
        let webViewConfiguration: WKWebViewConfiguration = WKWebViewConfiguration()
        webViewConfiguration.allowsInlineMediaPlayback = true
        
        let userController = WKUserContentController()
        userController.addScriptMessageHandler(self, name: "playerReady")
        // We can add a protocol, to signal quality and state changes
        userController.addScriptMessageHandler(self, name: "observe")
        userController.addScriptMessageHandler(self, name: "observePlay")
        
        webViewConfiguration.userContentController = userController
        
        self.webView = WKWebView(frame: CGRectZero, configuration: webViewConfiguration)

        self.webView.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(self.webView)
        
        let wvwc = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.webView, attribute: NSLayoutAttribute.Width, multiplier: 1.0, constant: 0.0)
        self.addConstraint(wvwc)
        
        let wvhc = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.webView, attribute: NSLayoutAttribute.Height, multiplier: 1.0, constant: 0.0)
        self.addConstraint(wvhc)
        
        let wvxc = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.webView, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)
        self.addConstraint(wvxc)
        
        let wvyc = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.webView, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0.0)
        self.addConstraint(wvyc)
    }
    
    // MARK: WKScriptMessageHandler
    public func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        // This is the place were we can capture all the observed changes, and deliver through a delegate
        if message.name == "playerReady" {
//            self.playVideo()
        }
        if message.name == "observePlay" {
            print(message)
        }
    }
    
    private func playerHTMLPath() -> String {
        return NSBundle(forClass: self.classForCoder).pathForResource("YouTubePlayer", ofType: "html")!
    }
    
    private func loadHTML() {
        let rawHTMLString = htmlStringWithFilePath(playerHTMLPath())!
        
        let url: NSURL = NSURL(string: "about:blank")!
        self.webView.loadHTMLString(rawHTMLString as String, baseURL:url)
        
//        let js = "function onYouTubeIframeAPIReady(){ player=new YT.Player('player',{playerVars:{autoplay:1, controls:0, enablejsapi:0}, height:\"100%\",width:\"100%\",videoId:\"\(self.videoId)\",events:{onReady:onPlayerReady,onStateChange:onPlayerStateChange}})} function onPlayerReady(e){window.webkit.messageHandlers.playerReady.postMessage(\"\")} function onPlayerStateChange(e){window.webkit.messageHandlers.observe.postMessage(\"\");}function stopVideo(){player.stopVideo()} function playVideo(){player.playVideo(); window.webkit.messageHandlers.observePlay.postMessage(\"\");} function pauseVideo() {player.pauseVideo} function stopVideo() {player.stopVideo}"
//        let userScript = WKUserScript(source: js, injectionTime: WKUserScriptInjectionTime.AtDocumentStart, forMainFrameOnly: true)
//        self.webView.configuration.userContentController.addUserScript(userScript)
    }
    
    private func htmlStringWithFilePath(path: String) -> String? {
        do {
            let htmlString = try NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding)
            return htmlString as String
        } catch _ {
            print("Lookup error: no HTML file found for path")
            return nil
        }
    }
} */
