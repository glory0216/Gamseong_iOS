//
//  LoginViewController.swift
//  Gamseong
//
//  Created by YoungKwangLee on 2016. 12. 27..
//  Copyright © 2016년 YoungKwangLee. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {

    let fbLoginUrl = NSURL(string: "http://52.78.110.20:8080/gamseongAccounts/users/facebook")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(animated: Bool) {
        
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

    func fetchFBProfile() {
        let parameters = ["fields": "id, email, name, gender"]
        var tmpDic = [String:AnyObject]()
        if ((FBSDKAccessToken.currentAccessToken()) != nil) {
            FBSDKGraphRequest(graphPath: "me", parameters: parameters).startWithCompletionHandler({ (connection, result, error) -> Void in
                
                if (error != nil) {
                    print(error)
                    return
                }
                
                if let id = result["id"] as? String,
                email = result["email"] as? String,
                name = result["name"] as? String,
                gender = result["gender"] as? String
                {
                    print("id : \(id)")
                    print("email : \(email)")
                    print("name : \(name)")
                
                    tmpDic = ["id": id,
                        "account": email,
                        "name": name,
                        "gender": gender,
                        "imageUrl": "http://graph.facebook.com/\(id)/picture?width=270&height=270"
                    ]
                    
                    print("facebook user info : \(tmpDic)")
                    
                    self.fbLoginWithAlamofire(tmpDic)
                }
                
            })
        }
        
    }
    
    func fbLoginWithAlamofire(params: [String:AnyObject]) {
        Alamofire.request(.POST, fbLoginUrl!, encoding:.JSON, parameters: params)
            .responseJSON { response in
                switch response.result {
                case .Success(let JSON):
                    let response = JSON as! NSDictionary
                    
                    print("response : \(response)")
                    
                    let tokenKey = response.objectForKey("user")?.objectForKey("tokenKey")!
                    let account = response.objectForKey("user")?.objectForKey("account")!
                    let id = response.objectForKey("user")?.objectForKey("id")!
                    let name = response.objectForKey("user")?.objectForKey("name")!
                    if let imageUrl = response.objectForKey("user")?.objectForKey("imageUrl")! {
                        NSUserDefaults.standardUserDefaults().setValue(imageUrl, forKey: "imageUrl")
                    }
                    
                    NSUserDefaults.standardUserDefaults().setValue(tokenKey, forKey: "tokenKey")
                    NSUserDefaults.standardUserDefaults().setValue(account, forKey: "account")
                    NSUserDefaults.standardUserDefaults().setValue(id, forKey: "id")
                    NSUserDefaults.standardUserDefaults().setValue(name, forKey: "name")
                    
                case .Failure(let error):
                    let alertMessage = String(error)
                    self.displayDefaultAlertMessage(alertMessage)
                }
        }
    }   // End of fbLogin
    
    // MARK: - Alert
    func displayDefaultAlertMessage(userMessage:String) {
        
        let okAlert = UIAlertController(title: "알림", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.Default, handler: nil)
        
        okAlert.addAction(okAction)
        self.presentViewController(okAlert, animated: true, completion: nil)
    }
    
    
}
