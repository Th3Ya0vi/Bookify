//
//  SignupViewController.swift
//  Bookify
//
//  Created by Gerardo Vazquez on 3/14/16.
//  Copyright © 2016 Bookify. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD

class SignupViewController: UIViewController {
    
    var new = PFUser()
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var password2Field: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func signupButton(sender: AnyObject) {
        
        let progress = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        progress.labelText = "Sign up"
        progress.detailsLabelText = "Please wait"
        
        new.username = usernameField.text
        new.password = passwordField.text
        new.email = emailField.text
        
        if emailField.hasText() && usernameField.hasText() && passwordField.hasText(){
            print("Success: form is complete")
            if passwordField.text! == password2Field.text!{
                print("Success: passwords match")
                if emailField.text!.containsString("@tamu.edu"){
                    print("Success: TAMU email")
                    parseSignup()
                }
                else{
                    print("Error: not TAMU email")
                    progress.hide(true)
                    let alertController = UIAlertController(title: "Error", message: "Please use your TAMU email.", preferredStyle: .Alert)
                    let okayAction = UIAlertAction(title: "Okay", style: .Default) { (action) in
                        //print(action)
                    }
                    alertController.addAction(okayAction)
                    self.presentViewController(alertController, animated: true) {
                        // ...
                    }

                }
                progress.hide(true)
            }
            else{
                print("Error: password does not match")
                progress.hide(true)
                let alertController = UIAlertController(title: "Login", message: "Error. Please try again. Check your username or password.", preferredStyle: .Alert)
                let okayAction = UIAlertAction(title: "Okay", style: .Default) { (action) in
                    //print(action)
                }
                alertController.addAction(okayAction)
                self.presentViewController(alertController, animated: true) {
                    // ...
                }
            }
        }
        else{
            print("Error: empty signup fields")
            progress.hide(true)
            let alertController = UIAlertController(title: "Error", message: "Passwords do not match.", preferredStyle: .Alert)
            let okayAction = UIAlertAction(title: "Okay", style: .Default) { (action) in
                //print(action)
            }
            alertController.addAction(okayAction)
            self.presentViewController(alertController, animated: true) {
                // ...
            }
        }
    }
    
    func parseSignup(){
        /*** SIGN UP***/
        new.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if success {
                print("Success: user registered.")
                self.performSegueWithIdentifier("loginMenu", sender: nil)
                
            } else {
                print(error?.localizedDescription)
                //print("Error: invalid register.")
                //print(error?.code)
                if error?.code == 202 {
                    print("Error: user is taken in register.")
                    let alertUserTaken = UIAlertController(title: "Error", message: "Username is taken.", preferredStyle: .Alert)
                    let okayAction = UIAlertAction(title: "Okay", style: .Default) { (action) in
                        //print(action)
                    }
                    alertUserTaken.addAction(okayAction)
                    self.presentViewController(alertUserTaken, animated: true) {
                        // ...
                    }
                }
            }
        }
        /***SIGN UP***/
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
