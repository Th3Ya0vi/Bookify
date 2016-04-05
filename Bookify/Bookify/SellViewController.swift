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

var course = Courses()

class SellViewController: UIViewController, UINavigationControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    var book: [NSDictionary]?
//    var courseVal : String?
//    var numberVal :String?
    
    @IBOutlet weak var coursePickView: UIPickerView!
    @IBOutlet weak var coursePickField: UITextField!
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        coursePickView.delegate = self
        coursePickView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func deptIndex()->Int{
        return coursePickView.selectedRowInComponent(0)
    }
    
    func courseIndex()->Int{
        return coursePickView.selectedRowInComponent(1)
    }
    
    //number of scrolling picks or columns
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    //number of elements in column
    func pickerView(
        pickerView: UIPickerView,
        numberOfRowsInComponent component: Int
        ) -> Int {
        
        switch component {
            
        case 0:
            return course.courseValues().count
        case 1:
            return course.numberValues(deptIndex()).count
        default:
            return 0
        }
    }
    
    //[[String]] returns string for each label using matrix
    func pickerView(
        pickerView: UIPickerView,
        titleForRow row: Int,
        forComponent element: Int
        ) -> String? {
        
        switch element {
            
        case 0:
            return course.courseValues()[row]
        case 1:
            return course.numberValues(deptIndex())[row]
        default:
            return "Error"
        }

    }
    
    // Catpure the picker view selection
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        
        //here we set the values to our locally
        let courseVal = course.courseValues()[deptIndex()]
        let numberVal = course.numberValues(deptIndex())[courseIndex()]
        
        course.setCouseDep(withCourse: courseVal)
        course.setCouseDep(withCourse: numberVal)
        
        //set values to current view and model
        coursePickField.text =  courseVal + (numberVal)
        
        
    }
    
    @IBAction func onNext(sender: AnyObject) {
        
        course.course = course.courseValues()[deptIndex()]
        course.number = course.numberValues(deptIndex())[courseIndex()]
        
        let alertController = UIAlertController(title: "Post", message: "Select option", preferredStyle: .Alert)
        
        let manualAction = UIAlertAction(title: "Manually", style: .Default) { (action) in
            //action when clicked
            self.performSegueWithIdentifier("Post", sender: nil)
        }
        let autoAction = UIAlertAction(title: "ISBN", style: .Default) { (action) in
            //action when clicked
            self.performSegueWithIdentifier("Search", sender: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) { (action) in
            //print(action)
        }
        
        alertController.addAction(autoAction)
        alertController.addAction(manualAction)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true) {
            // ...
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
