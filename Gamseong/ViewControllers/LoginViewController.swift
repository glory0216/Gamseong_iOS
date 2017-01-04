//
//  LoginViewController.swift
//  Gamseong
//
//  Created by YoungKwangLee on 2016. 12. 27..
//  Copyright © 2016년 YoungKwangLee. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

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
    @IBAction func moveToLoginDVC(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginDetailViewController = storyboard.instantiateViewControllerWithIdentifier("LoginDetailVC") as! LoginDetailViewController
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.rootViewController = loginDetailViewController
        
    }

    @IBAction func moveToSignupVC(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signupViewController = storyboard.instantiateViewControllerWithIdentifier("SignupVC") as! SignupViewController
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.rootViewController = signupViewController
    }
    
    @IBAction func touchLoginWithFacebookBtn(sender: AnyObject) {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logInWithReadPermissions(["email"], fromViewController: self) { (result, error) -> Void in
            if (error == nil) {
                let fbloginresult : FBSDKLoginManagerLoginResult = result
                if (fbloginresult.grantedPermissions.contains("email")) {
                    self.fetchFBProfile()
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let revealViewController = storyboard.instantiateViewControllerWithIdentifier("RevealViewController") as! SWRevealViewController
                    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    appDelegate.window?.rootViewController = revealViewController
                }
            }
        }
        
    }
    
    func fetchFBProfile(){
        let parameters = ["fields": "id, email, first_name, last_name, picture.type(large)"]
        if ((FBSDKAccessToken.currentAccessToken()) != nil) {
            FBSDKGraphRequest(graphPath: "me", parameters: parameters).startWithCompletionHandler({ (connection, result, error) -> Void in
                if (error == nil) {
                    //everything works print the user data
                    print(result)
                }
            })
        }
    }


}
