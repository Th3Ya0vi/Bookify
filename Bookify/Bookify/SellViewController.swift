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
import FontAwesome_swift

class SellViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var search: UIButton!
    @IBAction func search(sender: AnyObject) {
        self.performSegueWithIdentifier("Search", sender: nil)
    }
    
    @IBOutlet weak var exitManuallyButton: UIButton!
    @IBOutlet weak var enterManuallyButton: UIButton!
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
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        hideManual()
        search.alpha = 1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onManual(sender: AnyObject) {
        //self.performSegueWithIdentifier("Post", sender: nil)
        hideManual()
    }
    
    @IBAction func onManually(sender: AnyObject) {
        showManual()
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
        
        if isValidIsbn(){
            //Show HUD before the request is made
            let HUDindicator = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            HUDindicator.labelText = "Loading Book"
            HUDindicator.detailsLabelText = "Please wait"
            
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
        }
        else{
            print("Error: Not a valid ISBN")
        }
        showManual()
    }
    
    @IBAction func onPost(sender: AnyObject) {
        
        //Show HUD before the request is made
        let HUDindicator = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        HUDindicator.labelText = "Posting"
        HUDindicator.detailsLabelText = "Please wait"
        
        if previewCover.image != nil && titleField.hasText() && authorField.hasText() && isbnField.hasText(){
            Post.postUserBook(previewCover.image, withTitle: titleField.text, withAuthor: authorField.text, withIsbn: isbnField.text) { (success: Bool, error:NSError?) -> Void in
                if success {
                    print("Success: posted to Parse")
                    self.hideManual()
                    self.previewCover.image = nil
                    self.titleField.text = ""
                    self.authorField.text = ""
                    self.isbnField.text = ""
                    
                    HUDindicator.hide(true)
                    
                    let alertUserTaken = UIAlertController(title: "Success", message: "You have posted your book!", preferredStyle: .Alert)
                    let okayAction = UIAlertAction(title: "Okay", style: .Default) { (action) in
                        //print(action)
                        self.performSegueWithIdentifier("Popular", sender: nil)

                    }
                    alertUserTaken.addAction(okayAction)
                    self.presentViewController(alertUserTaken, animated: true) {
                        // ...
                    }
                    

                }
                else {
                    print("Error: can't post to parse")
                    self.hideManual()
                    HUDindicator.hide(true)
                    let alertUserTaken = UIAlertController(title: "Error", message: "Can't post to Bookify.", preferredStyle: .Alert)
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
        else{
            print("Error: fields missing")
            HUDindicator.hide(true)
            
            let alertUserTaken = UIAlertController(title: "Error", message: "Please complete submission.", preferredStyle: .Alert)
            let okayAction = UIAlertAction(title: "Okay", style: .Default) { (action) in
                //print(action)
            }
            alertUserTaken.addAction(okayAction)
            self.presentViewController(alertUserTaken, animated: true) {
                // ...
            }

        }
    }
    
    func isValidIsbn() -> Bool{
        if searchIsbnField.hasText(){
            //let isbn = searchIsbnField.text! as String
            return true
        }
        else{
            return false
        }
    }
    
    func parseDictionary(){
        if self.book != nil{
            let items = book![0]
            let volumeInfo = items["volumeInfo"]
            
            //title
            let title = volumeInfo?["title"] as? String
            //print ("Title \(title)")
            titleField.text = title
            
            //image
            let imageLinks = volumeInfo?["imageLinks"]
            let thumbnail = imageLinks!?["thumbnail"] as? String
            //print("url \(thumbnail)")
            let imageUrl = NSURL(string: thumbnail!)
            previewCover.setImageWithURL(imageUrl!)
            
            //author
            let authors = volumeInfo?["authors"]
            authorField.text = authors!![0] as? String
            //print(authors)
            
            //isbn
            isbnField.text = searchIsbnField.text
        }
        else{
            print("Error: no book")
        }
    }

    func hideManual(){
        
        searchIsbnField.alpha = 1
        searchButton.alpha = 1
        searchIsbnLabel.alpha = 1
        
        titleField.hidden = true
        authorField.hidden = true
        isbnField.hidden = true
        titleLabel.hidden = true
        authorLabel.hidden = true
        isbnLabel.hidden = true
        pictureButton.hidden = true
        postButton.hidden = true
        enterManuallyButton.hidden = false
        exitManuallyButton.hidden = true
        
        previewCover.hidden = true
    }
    
    func showManual(){
        
        titleField.hidden = false
        authorField.hidden = false
        isbnField.hidden = false
        titleLabel.hidden = false
        authorLabel.hidden = false
        isbnLabel.hidden = false
        pictureButton.hidden = false
        postButton.hidden = false
        enterManuallyButton.hidden = true
        exitManuallyButton.hidden = false
        
        previewCover.hidden = false
        
        
        searchIsbnField.alpha = 0
        searchButton.alpha = 0
        searchIsbnLabel.alpha = 0
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
