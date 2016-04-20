//
//  Post.swift
//  Bookify
//
//  Created by Gerardo Vazquez on 3/15/16.
//  Copyright © 2016 Bookify. All rights reserved.
//

import UIKit
import Parse

class Post: NSObject {
    /**
     * Other methods
     */
     
     /**
     Method to add a user post to Parse (uploading image file)
     
     - parameter image: Image that the user wants upload to parse
     - parameter caption: Caption text input by the user
     - parameter completion: Block to be executed after save operation is complete
     */
    class func postUserBook(image: UIImage?, withTitle title: String?, withAuthor author: String?, withIsbn10 isbn10: String?, withIsbn13 isbn13: String?, withClass name: String?, withCompletion completion: PFBooleanResultBlock?) -> Void {
        
        // Create Parse object PFObject
        let post = PFObject(className: "Book")
        
        // Add relevant fields to the object
        post["cover"] = getPFFileFromImage(image) // PFFile column type
        post["user"] = PFUser.currentUser()// Pointer column type that points to PFUser
        post["username"] = PFUser.currentUser()?.username
        post["isbn"] = isbn10
        post["isbn"] = isbn13
        post["title"] = title
        post["class"] = name
            
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackgroundWithBlock(completion)
    }
    
    class func setProfilePicture(profilePic: UIImage?, withCompletion completion: PFBooleanResultBlock?) {
        let profile = PFObject(className: "Profile")
        profile["user"] = PFUser.currentUser()?.username
        profile["profilepicture"] = profilePic
        // Save object
        profile.saveInBackgroundWithBlock(completion)
    }
    
    class func postMessage(singleMessage: String, withCompletion completion: PFBooleanResultBlock?) {
        let message = PFObject(className: "Messages")
        message["username"] = PFUser.currentUser()?.username
        message["message"] = singleMessage
        // Save object
        message.saveInBackgroundWithBlock(completion)
    }
    
    /**
     Method to convert UIImage to PFFile
     - parameter image: Image that the user wants to upload to parse
     - returns: PFFile for the the data in the image
     */
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
}
