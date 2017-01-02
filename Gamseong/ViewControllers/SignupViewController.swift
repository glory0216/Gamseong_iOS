//
//  SignupViewController.swift
//  Gamseong
//
//  Created by YoungKwangLee on 2016. 12. 27..
//  Copyright © 2016년 YoungKwangLee. All rights reserved.
//

import UIKit

class SignupViewController: InitViewController {

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
    

}
