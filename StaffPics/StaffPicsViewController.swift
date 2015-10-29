//
//  StaffPicsViewController.swift
//  StaffPics
//
//  Created by Austin Williams on 8/25/15.
//  Copyright (c) 2015 Austin Willimas. All rights reserved.
//

import UIKit

class StaffPicsViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView?
    
    var items: Array<Video> = []
    
    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "Staff Pics"
        
        // Breakout setup stuff into different methods
        self.setupTableView()
        
        self.refreshItems()
    }
    
    
    // MARK: Setup
    
    func setupTableView()
    {
        let nib = UINib(nibName: "VideoCell", bundle: nil)
        self.tableView?.registerNib(nib, forCellReuseIdentifier: NSStringFromClass(VideoCell))
    }
    
    // MARK: UITableViewDatasource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(VideoCell)) as! VideoCell
        
        let video = self.items[indexPath.row]
        cell.video = video

        
        return cell
    }
    
    func refreshItems(){
        
        VimeoClient.staffpicks { (videos, error) -> Void in
            
            if let constVideos = videos{
                
                self.items = constVideos
                
                self.tableView?.reloadData()
                
            }
            else {
                //TODO: Alert the user
            }
            
            
        }
        
    }
    
    
}
