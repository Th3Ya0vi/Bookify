//
//  ProfileVisitViewController.swift
//  Bookify
//
//  Created by Neal Patel on 4/20/16.
//  Copyright © 2016 Bookify. All rights reserved.
//

import UIKit

class ProfileVisitViewController: UIViewController {

    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var collegeMajorLabel: UILabel!
    @IBOutlet weak var profileDescriptionTextView: UITextView!
    @IBOutlet weak var numberOfBooksPosted: UILabel!
    @IBOutlet weak var numberOfBooksSold: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.usernameLabel.text = (bookArray!["username"]) as? String
    }
    
    override func viewDidAppear(animated: Bool) {
        self.usernameLabel.text = (bookArray!["username"]) as? String
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func messageUser(sender: AnyObject) {
        self.performSegueWithIdentifier("goToChat", sender: nil)
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
