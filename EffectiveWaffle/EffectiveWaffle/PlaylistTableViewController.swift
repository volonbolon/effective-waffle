//
//  PlaylistTableViewController.swift
//  EffectiveWaffle
//
//  Created by Ariel Rodriguez on 12/14/15.
//  Copyright © 2015 Ariel Rodriguez. All rights reserved.
//

import UIKit

class PlaylistCell: UITableViewCell {
    @IBOutlet weak var videoThumb: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
}

class PlaylistTableViewController: UITableViewController {
    var channel:Channel!
    private let apiClient = APIClient()
    var videos:[Video] = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 80.0
        self.title = self.channel.name
        self.apiClient.getVideos(self.channel.playlistId) { (e:Either<[Video], APIClientError>) -> Void in
            switch e {
            case .Left(let videos):
                self.videos = videos
                self.tableView.reloadData()
            case .Right:
                break
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.videos.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PlaylistCell", forIndexPath: indexPath) as! PlaylistCell

        let video = self.videos[indexPath.row]
        
        cell.titleLabel.text = video.name
        cell.infoLabel.text = video.videoInfo

        let request = NSURLRequest(URL: video.thumbs.first!.url)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request, completionHandler: { (d:NSData?, r:NSURLResponse?, e:NSError?) -> Void in
            if d != nil {
                if let image = UIImage(data:d!) {
                    let queue = NSOperationQueue.mainQueue()
                    queue.addOperationWithBlock({ () -> Void in
                        if let cu = self.tableView.cellForRowAtIndexPath(indexPath) as? PlaylistCell {
                            cu.videoThumb.image = image
                        }
                    })
                }
            }
        })
        task.resume()
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
