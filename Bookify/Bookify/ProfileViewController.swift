//
//  ProfileViewController.swift
//  Bookify
//
//  Created by Gerardo Vazquez on 3/9/16.
//  Copyright © 2016 Bookify. All rights reserved.
//

import UIKit
import Foundation
import MessageUI
import Parse

class ProfileViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MFMessageComposeViewControllerDelegate {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var collegeMajorLabel: UILabel!
    @IBOutlet weak var numberOfBooksPosted: UILabel!
    @IBOutlet weak var numberOfBooksSold: UILabel!
    @IBOutlet weak var holdPickerView: UIView!
    @IBOutlet weak var collegeMajorPickerView: UIPickerView!
    @IBOutlet weak var saveChange: UIButton!
    @IBOutlet weak var editProfile: UIButton!
  
    // Needed just for fading out
    @IBOutlet weak var profileDescriptionTextView: UITextView!
    @IBOutlet weak var locationIcon: UIImageView!
    @IBOutlet weak var collegeNameLabel: UILabel!
    @IBOutlet weak var gradIconImageView: UIImageView!
    @IBOutlet weak var numBS: UILabel!
    @IBOutlet weak var numBP: UILabel!
    
    // Profile Picture Button
    var profileButton = UIButton()
    
    // Description Button
    var descriptionButton = UIButton()
    
    // Profile Picture
    var profileImages: NSArray?
    
    var majors = ["Computer Science", "Electrical Engineering"]
    var counter = 0
    var blurEffect = UIBlurEffect()
    var blurView = UIVisualEffectView()
    var editButton = UIButton()
    
    @IBAction func onLogout(sender: AnyObject) {
        PFUser.logOut()
        self.performSegueWithIdentifier("logout", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.sendSubviewToBack(holdPickerView)
        // Set username
        usernameLabel.text = PFUser.currentUser()?.username
        
        // UIPickerView Data Source and Delegate
        self.collegeMajorPickerView.dataSource = self
        self.collegeMajorPickerView.delegate = self
        
        // Trigger College Major Label click
        let tempButton = UIButton()
        tempButton.frame = collegeMajorLabel.frame
        print("tempView height, width: \(tempButton.frame.height), \(tempButton.frame.width)")
        print("College major label height, width: \(collegeMajorLabel.frame.height), \(collegeMajorLabel.frame.width)")
        tempButton.addTarget(self, action: #selector(ProfileViewController.showPickerView), forControlEvents: .TouchUpInside)
        self.view.addSubview(tempButton)
    }
    
    func fadeInPickerView(duration duration: NSTimeInterval = 0.5) {
        UIView.animateWithDuration(duration, animations: {
            self.blurUI()
            self.blurView.alpha = 1
            self.holdPickerView.alpha = 1
            self.collegeMajorPickerView.alpha = 1
            self.saveChange.alpha = 0.7
            self.view.bringSubviewToFront(self.blurView)
            self.view.bringSubviewToFront(self.holdPickerView)
        })
    }
    
    func blurUI() {
        self.editProfile.alpha = 0
        self.profileImageView.alpha = 0
        self.usernameLabel.alpha = 0
        self.collegeMajorLabel.alpha = 0
//        self.numberOfBooksPosted.alpha = 0
//        self.numberOfBooksSold.alpha = 0
//        self.profileDescriptionTextView.alpha = 0
        self.collegeNameLabel.alpha = 0
        self.blurView.alpha = 1
        self.gradIconImageView.alpha = 0
//        self.numBP.alpha = 0
        self.collegeMajorLabel.alpha = 0
        self.locationIcon.alpha = 0
//        self.numBS.alpha = 0
        self.editButton.alpha = 0
    }
    
    func fadeOutEditLabel(duration duration: NSTimeInterval = 0.5) {
        UIView.animateWithDuration(duration, animations: {
            self.editProfile.alpha = 0
            self.editButton.alpha = 1
            self.editButton.setImage(UIImage(named: "XOut"), forState: .Normal)
            self.editButton.imageView?.image = UIImage(named: "XOut")
            self.editButton.frame = CGRect(x: 300, y: 70, width: 70, height: 70)
            self.editButton.addTarget(self, action: #selector(ProfileViewController.fadeOutX), forControlEvents: .TouchUpInside)
            self.view.addSubview(self.editButton)
            self.view.bringSubviewToFront(self.editButton)
            self.darkenUI()
        })
    }
    
    func darkenUI(duration duration: NSTimeInterval = 0.5) {
        self.profileImageView.alpha = 1
        self.collegeMajorLabel.alpha = 1
//        self.profileDescriptionTextView.alpha = 1
        self.locationIcon.alpha = 1
        self.collegeNameLabel.alpha = 1
        self.usernameLabel.alpha = 1
        self.gradIconImageView.alpha = 1
//        self.numberOfBooksPosted.alpha = 1
//        self.numberOfBooksSold.alpha = 1
    }
    
    func lightenUI(duration duration: NSTimeInterval = 0.5) {
        self.profileImageView.alpha = 0.5
        self.collegeMajorLabel.alpha = 0.4
//        self.profileDescriptionTextView.alpha = 0.4
        self.locationIcon.alpha = 0.4
        self.collegeNameLabel.alpha = 0.4
        self.usernameLabel.alpha = 1
        self.gradIconImageView.alpha = 0.4
//        self.numberOfBooksPosted.alpha = 0.4
//        self.numberOfBooksSold.alpha = 0.4
    }
    
    func fadeInEditLabel(duration duration: NSTimeInterval = 0.5) {
        UIView.animateWithDuration(duration, animations: {
            
            self.editProfile.alpha = 0.7
        })
    }
    
    @IBAction func editProfileButtonPressed(sender: AnyObject) {
        print("height is \(self.editProfile.frame.size.height) width is \(self.editProfile.frame.size.width)")
        self.editButton.frame = CGRect(x: 300, y: 70, width: 70, height: 70)
        self.editButton.alpha = 0
        fadeOutEditLabel()
        print("edit label is \(self.editButton.frame)")
        self.profileButton.frame = self.profileImageView.frame
        self.profileButton.addTarget(self, action: #selector(ProfileViewController.choosePicture), forControlEvents: .TouchUpInside)
        self.view.addSubview(self.profileButton)
    }
    
    func choosePicture() {
        if self.locationIcon.alpha == 1 {
            self.blurUI()
            let alertController = UIAlertController(title: nil, message: "Choose which way you want to set a new profile picture.", preferredStyle: .ActionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
                // ...
                print("Cancel pressed")
                self.fadeOutPicker()
            }
            
            alertController.addAction(cancelAction)
            
            let cameraAction = UIAlertAction(title: "Camera", style: .Default) { (action) in
                // ...
            }
            
            alertController.addAction(cameraAction)
            
            let uploadAction = UIAlertAction(title: "Choose From Library", style: .Default) { (action) in
                let vc = UIImagePickerController()
                vc.delegate = self
                vc.allowsEditing = true
                vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                self.presentViewController(vc, animated: true, completion: nil)
            }
            
            alertController.addAction(uploadAction)
            
//            let destroyAction = UIAlertAction(title: "Destroy", style: .Destructive) { (action) in
//                print(action)
//                self.fadeOutPicker()
//            }
//            alertController.addAction(destroyAction)
            
            self.presentViewController(alertController, animated: true) {
                // ...
            }
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
        self.fadeOutPicker()
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print("got image")
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            Post.setProfilePicture(self.profileImageView.image!, withCompletion: { (success: Bool, error: NSError?) in
                if success {
                    print("successfully posted profile picture to Parse")
                    self.profileImageView.image = originalImage
                } else {
                    print("failed to post profile picture to Parse")
                    let alertController = UIAlertController(title: "Failed", message: "You may have a bad connection. Try again later.", preferredStyle: .Alert)
                    
                    let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
                        // ...
                        print("Cancel pressed")
                        self.fadeOutPicker()
                    }
                    alertController.addAction(cancelAction)
                    self.presentViewController(alertController, animated: true) {
                        // ...
                    }
                }
            })
        dismissViewControllerAnimated(true, completion: nil)
        self.fadeOutPicker()
    }
    
    func fadeOutX() {
        fadeOX()
    }
    
    func fadeOX(duration duration: NSTimeInterval = 0.5) {
        UIView.animateWithDuration(duration, animations: {
            self.editButton.alpha = 0
            self.fadeInEditLabel()
            self.lightenUI()
        })
    }
    
    func fadeInX(duration duration: NSTimeInterval = 1.0) {
        UIView.animateWithDuration(duration, animations: {
            self.editButton.alpha = 1
        })
    }
    
    func fadeOutPicker() {
        self.holdPickerView.alpha = 0
        self.collegeMajorPickerView.alpha = 0
        self.saveChange.alpha = 0
        self.profileImageView.alpha = 0.5
        self.usernameLabel.alpha = 1
        self.locationIcon.alpha = 0.4
//        self.profileDescriptionTextView.alpha = 0.4
        self.collegeNameLabel.alpha = 0.4
        self.gradIconImageView.alpha = 0.4
        self.collegeMajorLabel.alpha = 0.4
//        self.numberOfBooksPosted.alpha = 0.4
//        self.numberOfBooksSold.alpha = 0.4
        self.editProfile.alpha = 0.7
        self.blurView.alpha = 0
//        self.numBS.alpha = 1
//        self.numBP.alpha = 1
        self.view.sendSubviewToBack(self.holdPickerView)
    }
    
    func fadeOutPickerView(duration duration: NSTimeInterval = 0.5) {
        UIView.animateWithDuration(duration, animations: {
            self.holdPickerView.alpha = 0
            self.collegeMajorPickerView.alpha = 0
            self.saveChange.alpha = 0
            self.profileImageView.alpha = 0.5
            self.usernameLabel.alpha = 1
            self.locationIcon.alpha = 0.4
//            self.profileDescriptionTextView.alpha = 0.4
            self.collegeNameLabel.alpha = 0.4
            self.gradIconImageView.alpha = 0.4
            self.collegeMajorLabel.alpha = 0.4
//            self.numberOfBooksPosted.alpha = 0.4
//            self.numberOfBooksSold.alpha = 0.4
            self.editProfile.alpha = 0.7
            self.blurView.alpha = 0
//            self.numBS.alpha = 1
//            self.numBP.alpha = 1
            self.view.sendSubviewToBack(self.holdPickerView)
        })
    }
    
    func showPickerView() {
        if self.locationIcon.alpha == 1.0 {
            print("pressed")
            // Blur self.view
            self.blurEffect = UIBlurEffect(style: .Light)
            self.blurView = UIVisualEffectView(effect: self.blurEffect)
            self.blurView.frame = self.view.frame
            self.blurView.center = self.view.center
            self.view.addSubview(self.blurView)
            self.blurView.alpha = 0
            self.fadeInPickerView()
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return majors[row]
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return majors.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @IBAction func saveCollegeMajorChange(sender: AnyObject) {
        // Write to college major label
        print("saved!")
        // Hide views
        self.editButton.alpha = 0
        fadeOutPickerView()
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        counter = row
    }
    
    func onInvite(sender: AnyObject) {
        if (MFMessageComposeViewController.canSendText()) {
            let messageVC = MFMessageComposeViewController()
            messageVC.body = "Hey, try out Bookify!"
            messageVC.recipients = [] // Optionally add some tel numbers
            messageVC.messageComposeDelegate = self
            // Open the SMS View controller
            presentViewController(messageVC, animated: true, completion: nil)
        }
    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        //... handle sms screen actions
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        //        self.view.bringSubviewToFront(self.profileDescriptionTextView)
        let query = PFQuery(className: "Profile")
        query.findObjectsInBackgroundWithBlock { (profilepicture: [PFObject]?, error: NSError?) -> Void in
            if let profilepicture = profilepicture {
                self.profileImages = profilepicture
            } else {
                // print(error?.localizedDescription)
            }
        }
//        picture = profileImages?[1]["profilepicture"] as? PFFile
//        print("picture is \(picture)")
        holdPickerView.alpha = 0
        collegeMajorPickerView.alpha = 0
        saveChange.alpha = 0
        self.view.sendSubviewToBack(holdPickerView)
        usernameLabel.text = PFUser.currentUser()?.username
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}