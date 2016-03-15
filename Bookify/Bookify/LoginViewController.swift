//
//  LoginViewController.swift
//  Bookify
//
//  Created by Gerardo Vazquez on 3/9/16.
//  Copyright © 2016 Bookify. All rights reserved.
//

import UIKit
import Parse
import ParseUI


class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func onSignin(sender: AnyObject) {
         /*** SIGN IN ***/
        PFUser.logInWithUsernameInBackground(usernameField.text!, password: passwordField.text!){
            (user: PFUser?, error: NSError?) -> Void in
            
            if user != nil {
                print("User login")
                //here is to direct the user directly to the popular
                self.performSegueWithIdentifier("Popular", sender: nil)
                
//                let vc: AnyObject? = self.storyboard?.instantiateViewControllerWithIdentifier("Popular")
//                self.presentViewController(vc as! UIViewController, animated: true, completion: nil)
            }
            else{
                print("error")
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
         /*** SIGN IN ***/
        
    }
    
    @IBAction func onSignup(sender: AnyObject) {
         /*** SIGN UP***/
        let new = PFUser()
        new.username = usernameField.text
        new.password = passwordField.text
        new.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if success {
                print("Yay, created a user!")
                self.performSegueWithIdentifier("Popular", sender: nil)
            } else {
                print(error?.localizedDescription)
                print("error sigup")
                print(error?.code)
                if error?.code == 202 {
                    print("Username is taken")
                    let alertUserTaken = UIAlertController(title: "Error", message: "Username is taken", preferredStyle: .Alert)
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
