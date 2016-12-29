//
//  NoticeViewController.swift
//  Gamseong
//
//  Created by YoungKwangLee on 2016. 12. 28..
//  Copyright © 2016년 YoungKwangLee. All rights reserved.
//

import UIKit

class NoticeViewController: UIViewController {
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // SWReveail View Connect
        if self.revealViewController() != nil {
            menuBtn.target = self.revealViewController()
            menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
