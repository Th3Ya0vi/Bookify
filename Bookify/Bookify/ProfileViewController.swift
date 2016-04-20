//
//  ProfileViewController.swift
//  Bookify
//
//  Created by Gerardo Vazquez on 3/9/16.
//  Copyright © 2016 Bookify. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController, UIAlertViewDelegate {
    
    @IBOutlet weak var settingsNavButton: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var fullScreenImageView: UIImageView!
    @IBOutlet var tapView: UIView?
    let tapRec = UITapGestureRecognizer()
    var blurEffectView = UIVisualEffectView()
    let button = UIButton()
    var button1 = UIButton()
    let circle = UIImageView()
    
    @IBAction func onLogout(sender: AnyObject) {
        PFUser.logOut()
        self.performSegueWithIdentifier("Login", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        settingsNavButton.alpha = 0.9
        tapRec.addTarget(self, action: "tappedView:")
        tapView!.addGestureRecognizer(tapRec)
        tapView?.userInteractionEnabled = true
        profilePictureImageView.contentMode = UIViewContentMode.ScaleAspectFill
        print("height is \(self.view.frame.size.height)")
        print("width is \(self.view.frame.size.width)")
        profilePictureImageView.layer.cornerRadius = profilePictureImageView.frame.size.width / 2.1
        profilePictureImageView.clipsToBounds = true
        profilePictureImageView.layer.borderWidth = 0.7
        profilePictureImageView.layer.borderColor = UIColor.whiteColor().CGColor
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame.size.height = headerImageView.frame.size.height
        blurEffectView.frame.size.width = headerImageView.frame.size.width
        
        print("headerView height: \(headerImageView.frame.size.height), blur height: \(blurEffectView.frame.size.height)")
        view.addSubview(blurEffectView)
        usernameLabel.text = PFUser.currentUser()?.username
//        self.tabBarItem.image = UIImage.fontAwesomeIconWithName(.User, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))

    }
    
    func tappedView(tapImageView: UITapGestureRecognizer) {
        print("profile tapped")
        fullScreenImageView.image = profilePictureImageView.image
        view.bringSubviewToFront(fullScreenImageView)
        fullScreenImageView.contentMode = .ScaleAspectFill
        fullScreenImageView.frame = self.view.frame
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight] // for supporting device rotation
        view.addSubview(blurEffectView)
        circle.image = fullScreenImageView.image
        circle.contentMode = UIViewContentMode.ScaleAspectFill
        print("height is \(self.view.frame.size.height)")
        print("width is \(self.view.frame.size.width)")
        circle.frame = CGRect(x: 71, y: 50, width: 150, height: 150)
        circle.center = CGPoint(x: 150, y: 190)
        circle.layer.cornerRadius = circle.frame.size.width / 2
        circle.clipsToBounds = true
        circle.layer.borderWidth = 0.7
        circle.layer.borderColor = UIColor.blackColor().CGColor
        view.addSubview(circle)
        button.setImage(UIImage(named: "XOut.png"), forState: .Normal)
        button.imageView?.contentMode = .ScaleAspectFit
        button.bounds = CGRect(x: 0, y: 0, width: 130, height: 40)
        button.center = CGPoint(x: 270, y: 120)
        button.addTarget(self, action: Selector("test"), forControlEvents: .TouchUpInside)
        self.view.addSubview(button)
        self.view.bringSubviewToFront(button)
        button1.bounds = CGRect(x: 0, y: 0, width: 200, height: 60)
        button1.center = CGPoint(x: 205, y: 310)
        button1.clipsToBounds = true
        button1.layer.cornerRadius = 4
        button1.frame.size.width = 90
        button1.frame.size.height = 30
        button1.setTitle("Message", forState: .Normal)
        button1.layer.borderColor = UIColor.blackColor().CGColor
        button1.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button1.backgroundColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1.0)
        button1.addTarget(self, action: Selector("goToChat"), forControlEvents: .TouchUpInside)
        self.view.addSubview(button1)
        self.view.bringSubviewToFront(button1)
        fullScreenImageView.alpha = 1
        blurEffectView.alpha = 1
        circle.alpha = 1
        button1.alpha = 1
        button.alpha = 1
        profilePictureImageView.alpha = 0
        usernameLabel.alpha = 0
    }
    
    func goToChat() {
        print("go to chat")
    }
    
    func test() {
        print("pressed")
        fullScreenImageView.alpha = 0
        blurEffectView.alpha = 0
        circle.alpha = 0
        button1.alpha = 0
        button.alpha = 0
        profilePictureImageView.alpha = 1
        usernameLabel.alpha = 1
        self.view.sendSubviewToBack(fullScreenImageView)
        self.view.sendSubviewToBack(blurEffectView)
        self.view.sendSubviewToBack(circle)
        self.view.sendSubviewToBack(button)
        self.view.sendSubviewToBack(button1)
        self.view.bringSubviewToFront(profilePictureImageView)
    }
    
    override func viewDidAppear(animated: Bool) {
//        let alertController = UIAlertController(title: "Profile", message: "NO PROFILE", preferredStyle: .Alert)
//        let cancelAction = UIAlertAction(title: "Okay", style: .Default) { (action) in
//            //print(action)
//        }
//        alertController.addAction(cancelAction)
//        self.presentViewController(alertController, animated: true) {
//            // ...
//        }
        
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

    // MARK: Allow for using Camera Roll / Camera
    
}
