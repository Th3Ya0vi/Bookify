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

class PopularViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchResultsUpdating {

    @IBOutlet weak var searchBarPlaceholder: UIView!
    @IBOutlet weak var popularBooksCollectionView: UICollectionView!
    
    var books: NSArray?
    var search : NSArray?
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        popularBooksCollectionView.dataSource = self
        popularBooksCollectionView.delegate = self
        
        // Initializing with searchResultsController set to nil means that
        // searchController will use this view controller to display the search results
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        
        // If we are using this same view controller to present the results
        // dimming it out wouldn't make sense.  Should set probably only set
        // this to yes if using another controller to display the search results.
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        
        // Sets this view controller as presenting view controller for the search interface
        definesPresentationContext = true
        
        //view to add search bar
        searchBarPlaceholder.addSubview(searchController.searchBar)
        automaticallyAdjustsScrollViewInsets = false
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // Show HUD before the request is made
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
                // print(error?.localizedDescription)
                HUDindicator.hide(true)
            }
        }
//         print("books are: \(books)")
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {

        // construct query
        let query = PFQuery(className: "Book")
        query.whereKey("title", containsString: searchController.searchBar.text! )
        query.limit = 20

        // fetch data asynchronously
        query.findObjectsInBackgroundWithBlock { (result: [PFObject]?, error: NSError?) -> Void in
            if let result = result {
                // do something with the array of object returned by the call
                self.books = result
                self.popularBooksCollectionView.reloadData()

            } else {
                // print(error?.localizedDescription)
            }
        }
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let books = books {
            return books.count
        } else {
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("clicked!")
        bookArray = (books?[indexPath.row]) as? PFObject
        self.performSegueWithIdentifier("bookCoverPressed", sender: nil)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = popularBooksCollectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! PopularBooksCollectionViewCell
        cell.picture = books?[indexPath.row]["cover"] as? PFFile
        cell.popularBookPoster.setTitle((books?[indexPath.row]["username"] as! String
), forState: .Normal)
//        print("book poster is \(cell.popularBookPoster.titleLabel?.text)")
//        print(self.books)
        cell.popularBooksImageView.userInteractionEnabled = true
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
