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
        
        
        searchController.searchBar.sizeToFit()
        searchBarPlaceholder.addSubview(searchController.searchBar)
        automaticallyAdjustsScrollViewInsets = false
        definesPresentationContext = true
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
        
        //print("books are: \(books)")
    }
    
    let data = ["New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX",
                "Philadelphia, PA", "Phoenix, AZ", "San Diego, CA", "San Antonio, TX",
                "Dallas, TX", "Detroit, MI", "San Jose, CA", "Indianapolis, IN",
                "Jacksonville, FL", "San Francisco, CA", "Columbus, OH", "Austin, TX",
                "Memphis, TN", "Baltimore, MD", "Charlotte, ND", "Fort Worth, TX"]
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            var filteredData = searchText.isEmpty ? data : data.filter({(dataString: String) -> Bool in
                return dataString.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil
            })
            popularBooksCollectionView.reloadData()
        }
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let books = books {
            return books.count
        } else {
            return 0
        }
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
