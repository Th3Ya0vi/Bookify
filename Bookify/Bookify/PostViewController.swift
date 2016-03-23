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
    
    func courseValues() -> [String] {
        return ["CSCE", "ECEN"]
    }
    
    func numberValues(withNumber: Int) -> [String] {
        if withNumber == 0 {
            return ["110", "111", "121", "181", "206", "221", "222", "291", "312", "313", "314", "315", "410", "411", "420", "434", "435", "436", "441", "443", "444", "462", "464", "470", "481", "482", "483", "485", "491", "604", "606", "608", "611", "614", "617", "620", "622", "624", "625", "629", "634", "635", "645", "646", "649", "655", "657", "663", "664", "665", "666", "680", "681", "684", "685", "691"]
            
        }
        else if withNumber == 1{
            return ["214", "215", "248", "285", "303", "314", "322", "325", "326", "350", "370", "403", "404", "414", "420", "438", "441", "442", "444", "447", "449", "451", "454", "455", "457", "460", "463", "464", "465", "472", "473", "474", "480", "485", "489", "491", "600", "601", "602", "604", "605", "614", "615", "620", "621", "622", "632", "635", "636", "646", "651", "654", "658", "664", "665", "675", "676", "681", "684", "685", "688", "691", "704", "710", "714", "738", "741", "742", "749", "752", "761", "762", "763", "765", "771", "772"]
            
        }
        else{
            return ["Error: out of index"]
        }
    }
    
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
                return courseValues().count
            }else if component == 1{
                return numberValues(getDept()).count
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
                return courseValues()[row]
            }
            else if element == 1{
                return numberValues(getDept())[row]
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
        titleField.text = courseValues()[getDept()] + numberValues(getDept())[getCourseNum()]
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
