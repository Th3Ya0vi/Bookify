//
//  PopularBookDetailViewController.swift
//  Bookify
//
//  Created by Neal Patel on 4/18/16.
//  Copyright © 2016 Bookify. All rights reserved.
//

import UIKit
import Parse

var bookArray: PFObject?

class PopularBookDetailViewController: UIViewController {

    @IBOutlet weak var bookCoverImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookAuthorLabel: UILabel!
    @IBOutlet weak var bookPosterProfile: UIButton!
    @IBOutlet weak var messageUserPressed: UIButton!
    
    let googAPI = GoogleAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("current book array is \(bookArray)")
        picture = bookArray?["cover"] as? PFFile
        bookPosterProfile.setTitle("Posted by \((bookArray!["username"] as! String))", forState: .Normal)
        bookTitleLabel.text = (bookArray!["title"]) as? String
//        bookAuthorLabel.text = (bookArray![""])
        messageUserPressed.setTitle("Message \((bookArray!["username"] as! String))", forState: .Normal)
    }

    override func viewDidAppear(animated: Bool) {
        picture = bookArray?["cover"] as? PFFile
        bookPosterProfile.setTitle("Posted by \((bookArray!["username"] as! String))", forState: .Normal)
    }
    
    var picture: PFFile? {
        didSet {
            print(picture)
            picture?.getDataInBackgroundWithBlock({ (data: NSData?, error: NSError?) -> Void in
                if error == nil {
                    self.bookCoverImageView.image = UIImage(data: data!)!
                    self.bookCoverImageView.contentMode = .ScaleAspectFit
                }
                else {
                    print(error?.localizedDescription)
                    print("ERROR")
                }
            })
        }
    }
    
    @IBAction func messageUser(sender: AnyObject) {
        self.performSegueWithIdentifier("goToChat", sender: nil)
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
