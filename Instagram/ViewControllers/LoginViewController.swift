//
//  LoginViewController.swift
//  Instagram
//
//  Created by Anthony Lee on 10/15/18.
//  Copyright © 2018 anthony. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    @IBOutlet weak var userTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func signIn(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: userTextField.text!, password: passwordTextField.text!) { (user, error) in
            if user != nil{
                print("Logged In!")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    
    @IBAction func signUp(_ sender: Any) {
        let user = PFUser()
        user.username = userTextField.text
        user.password = passwordTextField.text
        user.signUpInBackground { (success
            , error) in
            if success{
                print("User Created")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print(error?.localizedDescription)
            }
        }
    }
}
