//
//  PostViewController.swift
//  Bookify
//
//  Created by Gerardo Vazquez on 3/20/16.
//  Copyright © 2016 Bookify. All rights reserved.
//

import UIKit
import MBProgressHUD

class PostViewController: UIViewController, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var authorField: UITextField!
    @IBOutlet weak var isbnField: UITextField!
    @IBOutlet weak var coverImage: UIImageView!
    
    var withClass: String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PostViewController.actOnSpecialNotification), name: "Google", object: nil)
    }
    
    func actOnSpecialNotification() {
        titleField.text = google.title
        authorField.text = google.author
        isbnField.text = google.isbn10
        coverImage.setImageWithURL(google.imageUrl)
        
        print("Succes: notification")
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPost(sender: AnyObject) {
        
        withClass = course.course! + course.number!
        
        if (titleField.hasText() && authorField.hasText()){
            Post.postUserBook(coverImage.image, withTitle: titleField.text, withAuthor: authorField.text, withIsbn10: google.isbn10, withIsbn13: google.isbn13, withClass: withClass) { (good:Bool, error:NSError?) in
                if good{
                    print("Success: posted to Parse")
                    self.coverImage.image = nil
                    self.titleField.text = ""
                    self.authorField.text = ""
                    self.isbnField.text = ""
                    
                    self.performSegueWithIdentifier("Menu", sender: nil)
                    
                }
            }
        }
        else{
            print("Error: fill required fields")
        }
    }
    
    func imagePickerController(picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        coverImage.image = editedImage
        dismissViewControllerAnimated(true, completion: { () -> Void in
        })
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
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
