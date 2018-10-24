//
//  HomeFeedViewController.swift
//  Instagram
//
//  Created by Anthony Lee on 10/23/18.
//  Copyright © 2018 anthony. All rights reserved.
//

import UIKit
import Parse

class HomeFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var posts : [Post]?
    @IBOutlet weak var postsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        postsTableView.rowHeight = postsTableView.frame.height/2.5
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControl.Event.valueChanged)
        postsTableView.insertSubview(refreshControl, at: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchPosts()
    }
    
    // Makes a network request to get updated data
    // Updates the tableView with the new data
    // Hides the RefreshControl
    @objc func refreshControlAction(_ refreshControl: UIRefreshControl) {
        fetchPosts()
    }
    
    func fetchPosts(){
        // construct PFQuery
        let query = Post.query()!
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.includeKey("image")
        query.includeKey("caption")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackground { (posts , error) in
            if let posts = posts {
                // do something with the data fetched
                
                self.posts = posts as! [Post]
                print(posts.count)
                print("fetched posts \(posts[0]["media"])")
                self.postsTableView.reloadData()
            } else {
                // handle error
            }
        }
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        PFUser.logOutInBackground { (error) in
            //logout
            print("Logged out!")
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cameraPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "composeSegue", sender: nil)
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.instagramPost = posts?[indexPath.row]
        return cell
    }
 
}
