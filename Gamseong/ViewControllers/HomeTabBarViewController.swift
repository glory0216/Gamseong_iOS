//
//  HomeTabBarViewController.swift
//  Gamseong
//
//  Created by YoungKwangLee on 2016. 12. 27..
//  Copyright © 2016년 YoungKwangLee. All rights reserved.
//

import UIKit

class HomeTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let homeTabBar = self.tabBar
        let noticeSelectedImage = UIImage(named: "tabbar_selected_noticeIcon")?.imageWithRenderingMode(.AlwaysOriginal)
        let feedsSelectedImage = UIImage(named: "tabbar_selected_feedsIcon")?.imageWithRenderingMode(.AlwaysOriginal)
        let messageSelectedImage = UIImage(named: "tabbar_selected_messageIcon")?.imageWithRenderingMode(.AlwaysOriginal)
        
        (homeTabBar.items![0]).selectedImage = noticeSelectedImage
        (homeTabBar.items![1]).selectedImage = feedsSelectedImage
        (homeTabBar.items![2]).selectedImage = messageSelectedImage
        
        homeTabBar.tintColor = UIColor.orangeColor()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if FBSDKAccessToken.currentAccessToken() != nil {
            // Fetch user profile
            //fetchFBProfile()
        }
        else if NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn") == true {
            // Fetch user profile
        }
        else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginViewController = storyboard.instantiateViewControllerWithIdentifier("LoginVC") as! LoginViewController
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.window?.rootViewController = loginViewController
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    func fetchFBProfile() {
        let parameters = ["fields": "id, email, name"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).startWithCompletionHandler { (connection, result, error) -> Void in
            
            if (error != nil) {
                print(error)
                return
            }
            
            if let id = result["id"] as? String {
                print("id : \(id)")
                NSUserDefaults.standardUserDefaults().setValue(id, forKey: "id")
                NSUserDefaults.standardUserDefaults().setValue("http://graph.facebook.com/\(id)/picture?width=270&height=270", forKey: "imageUrl")
            }
            
            if let email = result["email"] as? String {
                print("email : \(email)")
                NSUserDefaults.standardUserDefaults().setValue(email, forKey: "email")
            }
            
            if let name = result["name"] as? String {
                print("name : \(name)")
                NSUserDefaults.standardUserDefaults().setValue(name, forKey: "name")
            }
     
        }
        
    }
    */
}