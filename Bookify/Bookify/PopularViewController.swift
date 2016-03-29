//
//  PopularViewController.swift
//  Bookify
//
//  Created by Gerardo Vazquez on 3/9/16.
//  Copyright © 2016 Bookify. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD

class PopularViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var popularBooksCollectionView: UICollectionView!
    
    var books: NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        self.tabBarItem.image = UIImage.fontAwesomeIconWithName(.Star, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
        popularBooksCollectionView.dataSource = self
        popularBooksCollectionView.delegate = self
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let books = books {
            return books.count
        } else {
            return 0
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //Show HUD before the request is made
        let HUDindicator = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        HUDindicator.labelText = "Loading"
        HUDindicator.detailsLabelText = "Please wait"
        
        let query = PFQuery(className: "Book")
        query.findObjectsInBackgroundWithBlock { (cover: [PFObject]?, error: NSError?) -> Void in
            if let cover = cover {
                self.books = cover
                self.popularBooksCollectionView.reloadData()
                HUDindicator.hide(true)
            } else {
                print(error?.localizedDescription)
                HUDindicator.hide(true)
            }
        }
        
        print("books are: \(books)")
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = popularBooksCollectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! PopularBooksCollectionViewCell
        cell.picture = books?[indexPath.row]["cover"] as? PFFile
        return cell
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        PFUser.logOut()
        self.performSegueWithIdentifier("Login", sender: nil)
        
        
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
