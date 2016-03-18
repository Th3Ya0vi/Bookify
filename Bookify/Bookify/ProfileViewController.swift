//
//  ProfileViewController.swift
//  Bookify
//
//  Created by Gerardo Vazquez on 3/9/16.
//  Copyright © 2016 Bookify. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIAlertViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }
    
    override func viewDidAppear(animated: Bool) {
        let alertController = UIAlertController(title: "Profile", message: "NO PROFILE", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "Okay", style: .Default) { (action) in
            //print(action)
        }
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true) {
            // ...
        }
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