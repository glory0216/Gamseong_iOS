//
//  FeedsViewController.swift
//  Gamseong
//
//  Created by YoungKwangLee on 2016. 12. 28..
//  Copyright © 2016년 YoungKwangLee. All rights reserved.
//

import UIKit

class FeedsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var feedsTableView: UITableView!
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    var feedsListArr = [[String:AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        feedsTableView.delegate = self
        feedsTableView.dataSource = self
        
        // SWReveail View Connect
        if self.revealViewController() != nil {
            menuBtn.target = self.revealViewController()
            menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        self.navigationItem.title = "강남구"
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        self.navigationItem.title = "강남구"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - TableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return feedsListArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FeedsTableViewCell", forIndexPath: indexPath)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
}
