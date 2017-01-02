//
//  AlertView.swift
//  Gamseong
//
//  Created by YoungKwangLee on 2016. 12. 28..
//  Copyright © 2016년 YoungKwangLee. All rights reserved.
//

import UIKit
import Alamofire

class InitViewController: UIViewController {

    // MARK: - URLs
    let signupUrl = NSURL(string: "http://52.78.110.20:8080/gamseongAccounts/users")
    let locationCodeUrl = NSURL(string: "http://52.78.110.20:8080/gamseong/locations/code")
    let loginUrl = NSURL(string: "http://52.78.110.20:8080/gamseongAccounts/users/login")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Alert
    func displayDefaultAlertMessage(userMessage:String) {
        
        let okAlert = UIAlertController(title: "알림", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.Default, handler: nil)
        
        okAlert.addAction(okAction)
        self.presentViewController(okAlert, animated: true, completion: nil)
    }
    
    // MARK: - Alamofire
    func loginWithAlamofire(params: [String:AnyObject]) {
        Alamofire.request(.POST, loginUrl!, encoding:.JSON, parameters: params)
            .responseJSON { response in
                switch response.result {
                case .Success(let JSON):
                    let response = JSON as! NSDictionary
                    
                    print(response)
                    
                    if (response.objectForKey("result") as! String == "success") {
                        
                        let tokenKey = response.objectForKey("user")?.objectForKey("tokenKey")!
                        let account = response.objectForKey("user")?.objectForKey("account")!
                        let id = response.objectForKey("user")?.objectForKey("id")!
                        let name = response.objectForKey("user")?.objectForKey("name")!
                        let imageUrl = response.objectForKey("user")?.objectForKey("imageUrl")!
                        
                        NSUserDefaults.standardUserDefaults().setValue(tokenKey, forKey: "tokenKey")
                        NSUserDefaults.standardUserDefaults().setValue(account, forKey: "account")
                        NSUserDefaults.standardUserDefaults().setValue(id, forKey: "id")
                        NSUserDefaults.standardUserDefaults().setValue(name, forKey: "name")
                        
                        if (imageUrl != nil) {
                            NSUserDefaults.standardUserDefaults().setValue(imageUrl, forKey: "imageUrl")
                        }
                        else {
                            NSUserDefaults.standardUserDefaults().setValue("img/person/per.png", forKey: "imageUrl")
                        }
                        
                        print(NSUserDefaults.standardUserDefaults())
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let revealViewController = storyboard.instantiateViewControllerWithIdentifier("RevealViewController") as! SWRevealViewController
                        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                        appDelegate.window?.rootViewController = revealViewController
                        
                    }
                    else if (response.objectForKey("result") as! String == "half") {
                        self.displayDefaultAlertMessage("이메일 인증을 해주세요.")
                    }
                    else {
                        self.displayDefaultAlertMessage("이메일 또는 비밀번호가 틀립니다.")
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let revealViewController = storyboard.instantiateViewControllerWithIdentifier("RevealViewController") as! SWRevealViewController
                        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                        appDelegate.window?.rootViewController = revealViewController
                    }
                    
                    
                case .Failure(let error):
                    let alertMessage = String(error)
                    self.displayDefaultAlertMessage(alertMessage)
                }
        }
        Alamofire.request(.GET, locationCodeUrl!)
            .responseJSON { response in
                switch response.result {
                case .Success(let JSON):
                    do {
                        let jsonData = try NSJSONSerialization.dataWithJSONObject(JSON, options: NSJSONWritingOptions.PrettyPrinted)
                        let convertedString = String(data: jsonData, encoding: NSUTF8StringEncoding)!
                        
                        print(convertedString)
                        
                    } catch let myJSONError {
                        print(myJSONError)
                    }
                    
                case .Failure(let error):
                    let alertMessage = String(error)
                    self.displayDefaultAlertMessage(alertMessage)
                }
        }
        
    }   // End of login
    
    func signupWithAlamofire(params: [String:AnyObject]) {
        Alamofire.request(.POST, signupUrl!, encoding:.JSON, parameters: params)
            .responseJSON { response in
                switch response.result {
                case .Success(let JSON):
                    let response = JSON as! NSDictionary
                    
                    print(response)
                    
                    if (response.objectForKey("result") as! String == "success") {
                        self.displayDefaultAlertMessage("회원가입이 완료 되었습니다. 이메일 인증 후 로그인해주세요.")
                    }
                    else {
                        self.displayDefaultAlertMessage("회원가입에 실패하였습니다.")
                    }
                    
                case .Failure(let error):
                    let alertMessage = String(error)
                    self.displayDefaultAlertMessage(alertMessage)
                }
        }
        Alamofire.request(.GET, locationCodeUrl!)
            .responseJSON { response in
                switch response.result {
                case .Success(let JSON):
                    do {
                        let jsonData = try NSJSONSerialization.dataWithJSONObject(JSON, options: NSJSONWritingOptions.PrettyPrinted)
                        let convertedString = String(data: jsonData, encoding: NSUTF8StringEncoding)!
                        
                        print(convertedString)
                        
                    } catch let myJSONError {
                        print(myJSONError)
                    }
                    
                case .Failure(let error):
                    let alertMessage = String(error)
                    self.displayDefaultAlertMessage(alertMessage)
                }
        }
        
    }   // End of signup
    
}
