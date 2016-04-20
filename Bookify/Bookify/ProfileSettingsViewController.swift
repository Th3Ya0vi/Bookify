//
//  ProfileSettingsViewController.swift
//  Bookify
//
//  Created by Neal Patel on 4/17/16.
//  Copyright © 2016 Bookify. All rights reserved.
//

import UIKit
import SRKControls

class ProfileSettingsViewController: UIViewController, SRKComboBoxDelegate, UITextFieldDelegate {

    @IBOutlet weak var myComboBox: SRKComboBox!
    let arrayForComboBox = ["A", "B", "C"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if let txt = textField as? SRKComboBox {
            txt.delegateForComboBox = self
            txt.showOptions()
            return false
        }
        return true
    }
    
    //MARK:- SRKComboBoxDelegate
    
    func comboBox(textField:SRKComboBox, didSelectRow row:Int) {
        if textField == self.myComboBox {
            self.myComboBox.text = self.arrayForComboBox[row]
        }
    }
    
    func comboBoxNumberOfRows(textField:SRKComboBox) -> Int {
        if textField == self.myComboBox {
            return self.arrayForComboBox.count
        } else {
            return 0
        }
    }
    
    func comboBox(textField:SRKComboBox, textForRow row:Int) -> String {
        if textField == self.myComboBox {
            return self.arrayForComboBox[row]
        } else {
            return ""
        }
    }
    
    func comboBoxPresentingViewController(textField:SRKComboBox) -> UIViewController {
        return self
    }
    
    func comboBoxRectFromWhereToPresent(textField:SRKComboBox) -> CGRect {
        return textField.frame
    }
    
    func comboBoxFromBarButton(textField:SRKComboBox) -> UIBarButtonItem? {
        return nil
    }
    
    func comboBoxTintColor(textField:SRKComboBox) -> UIColor {
        return UIColor.blackColor()
    }
    
    func comboBoxToolbarColor(textField:SRKComboBox) -> UIColor {
        return UIColor.whiteColor()
    }
    
    func comboBoxDidTappedCancel(textField:SRKComboBox) {
        textField.text = ""
    }
    
    func comboBoxDidTappedDone(textField:SRKComboBox) {
        print("Let's do some action here")
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
