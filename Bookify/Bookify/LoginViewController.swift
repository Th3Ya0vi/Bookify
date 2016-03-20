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
import MBProgressHUD

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func onSignin(sender: AnyObject) {
         /*** SIGN IN ***/
        
        let progress = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        progress.labelText = "Loading"
        progress.detailsLabelText = "Please wait"
        
        PFUser.logInWithUsernameInBackground(usernameField.text!, password: passwordField.text!){
            (user: PFUser?, error: NSError?) -> Void in
        
        progress.hide(true)
            
            if user != nil {
                print("Success: user login \(PFUser.currentUser()!.username)")
                //here is to direct the user directly to the popular
                self.segueToPopular()
            }
            else{
                print("Error: user login")
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
        self.performSegueWithIdentifier("Signup", sender: nil)
    }
    
    func segueToPopular(){
        self.performSegueWithIdentifier("loginMenu", sender: nil)
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
