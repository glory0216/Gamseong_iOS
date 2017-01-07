//
//  SignupViewController.swift
//  Gamseong
//
//  Created by YoungKwangLee on 2016. 12. 27..
//  Copyright © 2016년 YoungKwangLee. All rights reserved.
//

import UIKit
import Alamofire

class SignupViewController: UIViewController {

    let signupUrl = NSURL(string: "http://52.78.110.20:8080/gamseongAccounts/users")
    let locationCodeUrl = NSURL(string: "http://52.78.110.20:8080/gamseong/locations/code")
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
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

    //MARK: - Btn Actions
    @IBAction func touchSignupBtn(sender: AnyObject) {
        let userEmail = emailTextField.text
        let userPassword = passwordTextField.text
        let userName = nameTextField.text
        
        if (passwordTextField!.text != passwordConfTextField!.text) {
            displayDefaultAlertMessage("패스워드가 다릅니다.")
            return
        }
        else if ((emailTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)! || (passwordConfTextField.text?.isEmpty)! || (nameTextField.text?.isEmpty)!) {
            displayDefaultAlertMessage("모든 항목을 다 채워주세요.")
            return
        }
        
        let signupParams = ["account": userEmail! as String,
                            "password": userPassword! as String,
                            "name": userName! as String]
        
        signupWithAlamofire(signupParams)
        
    }
    
    @IBAction func touchCancelBtn(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewControllerWithIdentifier("LoginVC") as! LoginViewController
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.rootViewController = loginViewController
        
    }
    
    // MARK: - Alamofire
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

    // MARK: - Alert
    func displayDefaultAlertMessage(userMessage:String) {
        
        let okAlert = UIAlertController(title: "알림", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.Default, handler: nil)
        
        okAlert.addAction(okAction)
        self.presentViewController(okAlert, animated: true, completion: nil)
    }
    
    
}
