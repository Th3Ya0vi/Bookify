//
//  PostViewController.swift
//  Bookify
//
//  Created by Gerardo Vazquez on 3/20/16.
//  Copyright © 2016 Bookify. All rights reserved.
//

import UIKit
import MBProgressHUD

class PostViewController: UIViewController {
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var authorField: UITextField!
    @IBOutlet weak var isbnField: UITextField!
    @IBOutlet weak var classField: UITextField!
    
    var num: String?
    var dep: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PostViewController.actOnSpecialNotification), name: "Google", object: nil)
        num = course.getCourseNum()
        dep = course.getCouseDep()
    }
    
    func actOnSpecialNotification() {
        titleField.text = google.title
        authorField.text = google.author
        isbnField.text = google.isbn10
        classField.text = "CSCE"
        print(course.getCouseDep())
        print(course.getCourseNum())
        print("Succes: notification")
    }
    
    override func viewDidAppear(animated: Bool) {
        
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
