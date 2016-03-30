//
//  GoogleAPI.swift
//  Bookify
//
//  Created by Gerardo Vazquez on 3/18/16.
//  Copyright © 2016 Bookify. All rights reserved.
//

import UIKit
import Parse
import AFNetworking


class GoogleAPI: NSObject {
    
    var book: [NSDictionary]?
    var title : String?
    var author: String?
    var isbn: String?
    var previewCover: UIImageView?
    
    
    func onSearch(withIsbn isbn: String?) {

        let base = "https://www.googleapis.com/books/v1/volumes?q=+isbn:"
        let apiKey = "&key=AIzaSyC6LLlunLukIkI7iElDZZdXA4rQqqcMugo"
        //let isbn = "000"
        let googleAPI = "\(base)\(isbn)\(apiKey)"
        
        let url = NSURL(string: googleAPI)
        let request = NSURLRequest(
            URL: url!,
            cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil,
            delegateQueue: NSOperationQueue.mainQueue()
        )
        
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: { (dataOrNil, response, error) in
                                                                        
            if let data = dataOrNil {
                if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                    data, options:[]) as? NSDictionary {
                    print("response: \(responseDictionary)")
                   
                    self.book = responseDictionary["items"] as? [NSDictionary]
                    //print(self.book)
                    //self.parseDictionary()
                }
            }
        })
        task.resume()
        
    }

    func isValidIsbn(withIsbn isbn: String?) -> Bool {
        self.isbn = isbn
        if isbn == isbn{
            return true
        }
        else{
            return false
        }
    }
        
    func parseDictionary(){
        if book != nil{
            let items = book![0]
            let volumeInfo = items["volumeInfo"]
            
            //title
            let title = volumeInfo?["title"] as? String
            //print ("Title \(title)")
            self.title = title
            
            //image
            let imageLinks = volumeInfo?["imageLinks"]
            let thumbnail = imageLinks!?["thumbnail"] as? String
            //print("url \(thumbnail)")
            let imageUrl = NSURL(string: thumbnail!)
            self.previewCover!.setImageWithURL(imageUrl!)
            
            //author
            let authors = volumeInfo?["authors"]
            self.author = authors!![0] as? String
            //print(authors)
            
        }
        else{
            print("Error: no book")
        }
    }
    
}
