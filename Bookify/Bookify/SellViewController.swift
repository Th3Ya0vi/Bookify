//
//  SellViewController.swift
//  Bookify
//
//  Created by Gerardo Vazquez on 3/9/16.
//  Copyright © 2016 Bookify. All rights reserved.
//

import UIKit
import Parse
import AFNetworking
import MBProgressHUD

class SellViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var searchIsbnLabel: UILabel!
    @IBOutlet weak var searchIsbnField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var pictureButton: UIButton!
    @IBOutlet weak var isbnLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var isbnField: UITextField!
    @IBOutlet weak var authorField: UITextField!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var previewCover: UIImageView!
    @IBOutlet weak var postButton: UIButton!
    
    var book: [NSDictionary]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        hideManual()
    }
    
    func hideManual(){
        titleField.alpha = 0
        authorField.alpha = 0
        isbnField.alpha = 0
        titleLabel.alpha = 0
        authorLabel.alpha = 0
        isbnLabel.alpha = 0
        pictureButton.alpha = 0
        postButton.alpha = 0
        
        searchIsbnField.alpha = 1
        searchButton.alpha = 1
        searchIsbnLabel.alpha = 1
        
    }
    
    func showManual(){
        titleField.alpha = 1
        authorField.alpha = 1
        isbnField.alpha = 1
        titleLabel.alpha = 1
        authorLabel.alpha = 1
        isbnLabel.alpha = 1
        pictureButton.alpha = 1
        postButton.alpha = 1
        
        searchIsbnField.alpha = 0
        searchButton.alpha = 0
        searchIsbnLabel.alpha = 0
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
    
    @IBAction func onSearch(sender: AnyObject) {
        let base = "https://www.googleapis.com/books/v1/volumes?q=+isbn:"
        let apiKey = "&key=AIzaSyC6LLlunLukIkI7iElDZZdXA4rQqqcMugo"
        let isbn = searchIsbnField.text!
        
        let googleAPI = "\(base)\(isbn)\(apiKey)"
        
        let url = NSURL(string: googleAPI)
        let request = NSURLRequest(
            URL: url!,
            cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil,
            delegateQueue: NSOperationQueue.mainQueue()
        )
        
        //Show HUD before the request is made
                let HUDindicator = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                HUDindicator.labelText = "Loading"
                HUDindicator.detailsLabelText = "Please wait"
        
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            //print("response: \(responseDictionary)")
                            //Hide HUD after request is done
                            //HUDindicator.hide(true)
                            
                            self.book = responseDictionary["items"] as? [NSDictionary]
                            //self.tableView.reloadData()
                            //print(self.book)
                            
                            self.parseDictionary()
                            HUDindicator.hide(true)
                    }
                }
        })
        task.resume()
        
        showManual()
    }
    
    func parseDictionary(){
        if self.book != nil{
            let items = book![0]
            let volumeInfo = items["volumeInfo"]
            
            //title
            let title = volumeInfo!["title"] as? String
            //print ("Title \(title)")
            titleField.text = title
            
            //image
            let imageLinks = volumeInfo!["imageLinks"]
            let thumbnail = imageLinks!!["thumbnail"] as? String
            //print("url \(thumbnail)")
            let imageUrl = NSURL(string: thumbnail!)
            previewCover.setImageWithURL(imageUrl!)
            
            //author
            let authors = volumeInfo!["authors"]
            authorField.text = authors!![0] as? String
            //print(authors)
            
            //isbn
            isbnField.text = searchIsbnLabel.text
        }
        else{
            print("no book")
        }
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
