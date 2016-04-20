//
//  PopularBooksCollectionViewCell.swift
//  Bookify
//
//  Created by Neal Patel on 3/23/16.
//  Copyright © 2016 Bookify. All rights reserved.
//

import UIKit
import Parse

class PopularBooksCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var popularBooksImageView: UIImageView!

    @IBOutlet weak var popularBookPoster: UIButton!
    
    var picture: PFFile? {
        didSet {
            print(picture)
            picture?.getDataInBackgroundWithBlock({ (data: NSData?, error: NSError?) -> Void in
                if error == nil {
                    self.popularBooksImageView.image = UIImage(data: data!)!
                }
                else {
                    print(error?.localizedDescription)
                    print("ERROR")
                }
            })
        }
    }
}