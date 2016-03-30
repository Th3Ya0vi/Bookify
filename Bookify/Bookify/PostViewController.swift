//
//  PostViewController.swift
//  Bookify
//
//  Created by Gerardo Vazquez on 3/20/16.
//  Copyright © 2016 Bookify. All rights reserved.
//

import UIKit

class PostViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var coursePickView: UIPickerView!
    @IBOutlet weak var titleField: UITextField!
    
    func getDept()->Int{
        return coursePickView.selectedRowInComponent(0)
    }
    
    func getCourseNum()->Int{
        return coursePickView.selectedRowInComponent(1)
    }
    
    //number of scrolling picks
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
        
    }
    
    //number of course numbers for selected department
    func pickerView(
        pickerView: UIPickerView,
        numberOfRowsInComponent component: Int
        ) -> Int {
            if component == 0{
                return Courses.courseValues().count
            }else if component == 1{
                return Courses.numberValues(getDept()).count
            }else{
                return 0
            }
    }
    
    //[[String]] returns string for each label using matrix
    func pickerView(
        pickerView: UIPickerView,
        titleForRow row: Int,
        forComponent element: Int
        ) -> String? {
            if element == 0{
                return Courses.courseValues()[row]
            }
            else if element == 1{
                return Courses.numberValues(getDept())[row]
            }
            else{
                return "Error"
            }
    }
    
    // Catpure the picker view selection
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        
        //here we set the values to our local var before sending to parse
        titleField.text = Courses.courseValues()[getDept()] + Courses.numberValues(getDept())[getCourseNum()]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coursePickView.delegate = self
        coursePickView.dataSource = self
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
