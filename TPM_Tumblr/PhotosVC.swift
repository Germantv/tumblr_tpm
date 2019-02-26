//
//  PhotosVC.swift
//  TPM_Tumblr
//
//  Created by German Flores on 11/5/18.
//  Copyright © 2018 German Flores. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotosVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    /*property that will store data returned from network request
     *its convention to create properties at the top of class w/ outlets
     */
    var posts: [[String: Any]] = []
    let tags = ["poop", "codepath", "ios", "ny", "ifyoureReadingThisisTooLate", "silly", "GERMAN", "ILOVECODEomg"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        self.view.layer.backgroundColor = #colorLiteral(red: 0.2117647059, green: 0.2503766704, blue: 0.3647058824, alpha: 1)

        // Network request snippet
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data,
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                print(dataDictionary)
                
                // Get the posts and store in posts property
                    // Get the dictionary from the response key
                let responseDictionary = dataDictionary["response"] as! [String: Any]
                    // Store the returned array of dictionaries in our posts property
                self.posts = responseDictionary["posts"] as! [[String: Any]]
                
                
                // TODO: Reload the table views
                self.tableView.reloadData()
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 455
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let post = posts[indexPath.row]
        
        // photos is NOT nil, we can use it!
        if let photos = post["photos"] as? [[String: Any]] {
            // Get the photo url
            let photo = photos[0]
            let originalSize = photo["original_size"] as! [String: Any]
            let urlString = originalSize["url"] as! String
            let url = URL(string: urlString)
            // Set the image view
            // af_setImage(withURL: url!) - AlamoFire method retrieves image from url
           
            cell.imagePost.af_setImage(withURL: url!)
            cell.profileImage.af_setImage(withURL: url!)
        }
        cell.username.text = "user_" + indexPath.row.description
        let randomTag = Int.random(in: 0..<8)
        let randomInt = Int.random(in: 0..<9999)
        cell.hashtag.text = "#" + tags[randomTag]
        cell.notes.text = randomInt.description + " notes"
        return cell
    }

}
