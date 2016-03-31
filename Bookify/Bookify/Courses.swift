//
//  Courses.swift
//  Bookify
//
//  Created by Gerardo Vazquez on 3/22/16.
//  Copyright © 2016 Bookify. All rights reserved.
//

import UIKit

class Courses: NSObject {

    var course: String?
    var number: String?
    
    func setCouseDep(withCourse newCourse : String?){
        course = newCourse
    }
    
    func setCouseNum(withCourseNum newNum : String?){
        number = newNum
    }
    
    func getCouseDep() -> String?{
        return course
    }
    
    func getCourseNum() -> String?{
        return number
    }
    
    let courseDep = ["CSCE", "ECEN"]
    
    func courseValues() -> [String] {
        return courseDep
    }
    
    func getCourseDepString(withNumber : Int) -> String {
        return courseDep[withNumber]
    }

    func numberValues(withNumber: Int) -> [String] {
      
        switch withNumber {
        case 0:
            return ["110", "111", "121", "181", "206", "221", "222", "291", "312", "313", "314", "315", "410", "411", "420", "434", "435", "436", "441", "443", "444", "462", "464", "470", "481", "482", "483", "485", "491", "604", "606", "608", "611", "614", "617", "620", "622", "624", "625", "629", "634", "635", "645", "646", "649", "655", "657", "663", "664", "665", "666", "680", "681", "684", "685", "691"]
        case 1:
            return ["214", "215", "248", "285", "303", "314", "322", "325", "326", "350", "370", "403", "404", "414", "420", "438", "441", "442", "444", "447", "449", "451", "454", "455", "457", "460", "463", "464", "465", "472", "473", "474", "480", "485", "489", "491", "600", "601", "602", "604", "605", "614", "615", "620", "621", "622", "632", "635", "636", "646", "651", "654", "658", "664", "665", "675", "676", "681", "684", "685", "688", "691", "704", "710", "714", "738", "741", "742", "749", "752", "761", "762", "763", "765", "771", "772"]

        default:
            return ["Error"]

        }
       
    }
    
}
