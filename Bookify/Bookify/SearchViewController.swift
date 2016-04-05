//
//  SearchViewController.swift
//  Bookify
//
//  Created by Gerardo Vazquez on 3/20/16.
//  Copyright © 2016 Bookify. All rights reserved.
//

import UIKit

var google = GoogleAPI()

class SearchViewController: UIViewController {

    
    @IBOutlet weak var searchField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSearch(sender: AnyObject) {
        if searchField.hasText(){
            if google.isValidIsbn(withIsbn: searchField.text){
                //DO GOOGLE API
                google.saveIsbn(withIsbn: searchField.text!)
                google.onSearch()
                self.performSegueWithIdentifier("Post", sender: nil)
            }
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
            //NSUserDefaults().setObject(google, forKey: "Google")
    }
    
    // MARK: - Navigation

     //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //let vc = segue.destinationViewController as! PostViewController
        //vc.book
        
    }
    

}
