//
//  SellViewController.swift
//  Bookify
//
//  Created by Gerardo Vazquez on 3/9/16.
//  Copyright © 2016 Bookify. All rights reserved.
//

import UIKit
import Parse
import Font_Awesome_Swift

class SellViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var isbnField: UITextField!
    @IBOutlet weak var authorField: UITextField!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var previewCover: UIImageView!
    @IBOutlet weak var postButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        postButton.setFAIcon(FAType.Fa, iconSize: 25, forState: .Normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPicture(sender: AnyObject) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(vc, animated: true, completion: nil)

    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            
            previewCover.image = editedImage
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

    
    @IBAction func onPost(sender: AnyObject) {
        Post.postUserBook(previewCover.image, withTitle: titleField.text, withAuthor: authorField.text, withIsbn: isbnField.text) { (success: Bool, error:NSError?) -> Void in
            if success {
                print("Posted to Parse")
                self.previewCover.image = nil
                self.titleField.text = ""
                self.authorField.text = ""
                self.isbnField.text = ""
                
                let alertUserTaken = UIAlertController(title: "Success", message: "You have posted your book!", preferredStyle: .Alert)
                let okayAction = UIAlertAction(title: "Okay", style: .Default) { (action) in
                    //print(action)
                }
                alertUserTaken.addAction(okayAction)
                self.presentViewController(alertUserTaken, animated: true) {
                    // ...
                }

            }
            else {
                print("Can't post to parse")
            }

        }
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
