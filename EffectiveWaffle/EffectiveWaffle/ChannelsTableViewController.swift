//
//  ChannelsTableViewController.swift
//  EffectiveWaffle
//
//  Created by Ariel Rodriguez on 12/14/15.
//  Copyright © 2015 Ariel Rodriguez. All rights reserved.
//

import UIKit

class ChannelsTableViewController: UITableViewController {
    var channels:[String] = ["Numberphile","Apple"]
    private let apiClient = APIClient()
    private var selectedChannel:Channel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.channels.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChannelsCell", forIndexPath: indexPath)

        cell.textLabel?.text = channels[indexPath.row]

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.apiClient.getChannelInfo(self.channels[indexPath.row]) { (e:Either<Channel, APIClientError>) -> Void in
            switch e {
            case .Left(let channel):
                self.selectedChannel = channel
                self.performSegueWithIdentifier(Constants.SegueIdentifier.ShowPlaylist, sender: nil)
            case .Right:
                break
            }
        }
    }

    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let segueIdentifier = segue.identifier
        if segueIdentifier == Constants.SegueIdentifier.ShowPlaylist {
            let destination = segue.destinationViewController as! PlaylistTableViewController
            destination.channel = self.selectedChannel
        }
    }
}
