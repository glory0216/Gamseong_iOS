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
        
        // Facebook fetch profile
        if let token = FBSDKAccessToken.currentAccessToken() {
            fetchFBProfile()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func fetchFBProfile() {
        let parameters = ["fields": "id, email, first_name, last_name, picture.type(large)"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).startWithCompletionHandler { (connection, result, error) -> Void in
            
            if (error != nil) {
                print(error)
                return
            }
            
            if let id = result["id"] as? String {
                print(id)
            }
            
            if let email = result["email"] as? String {
                print(email)
            }
            
            if let picture = result["picture"] as? NSDictionary, data = picture["data"] as? NSDictionary, url = data["url"] as? String {
                print(url)
            }
            
        }
        
        
    }
    
}
