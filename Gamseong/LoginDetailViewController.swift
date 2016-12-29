//
//  LoginDetailViewController.swift
//  Gamseong
//
//  Created by YoungKwangLee on 2016. 12. 27..
//  Copyright © 2016년 YoungKwangLee. All rights reserved.
//

import UIKit

class LoginDetailViewController: InitViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    // MARK: - Btn Actions
    @IBAction func touchLoginBtn(sender: AnyObject) {
        let userEmail = emailTextField.text
        let userPassword = passwordTextField.text
        
        if (userEmail!.isEmpty || userPassword!.isEmpty) {
            displayDefaultAlertMessage("모든 항목을 다 채워주세요.")
            return
        }
        
        let loginParams = ["id" : userEmail! as String,
                           "password" : userPassword! as String]
        
        //loginWithAlamofire(loginParams)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let revealViewController = storyboard.instantiateViewControllerWithIdentifier("RevealViewController") as! SWRevealViewController
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.rootViewController = revealViewController
        
    }
    
    @IBAction func touchCancelBtn(sender: AnyObject) {
        
    }
    
}
