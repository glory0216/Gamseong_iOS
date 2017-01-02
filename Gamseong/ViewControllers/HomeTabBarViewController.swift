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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
