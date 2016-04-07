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
    var isbn10: String?
    var isbn13: String?
    var previewCover: UIImageView?
    var imageUrl = NSURL()
    var isbn : String!
    
    func onSearch() {
        
        let base = "https://www.googleapis.com/books/v1/volumes?q=+isbn:"
        let apiKey = "&key=AIzaSyC6LLlunLukIkI7iElDZZdXA4rQqqcMugo"
        let googleAPI = "\(base)\(isbn)\(apiKey)"
        
        //print(googleAPI)
        
        let url = NSURL(string: googleAPI)
        let request = NSURLRequest(
            URL: url!,
            cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
            timeoutInterval: 5)
        
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil,
            delegateQueue: NSOperationQueue.mainQueue()
        )
        
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: { (dataOrNil, response, error) in
            
            if let data = dataOrNil {
                if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                    data, options:[]) as? NSDictionary {
                    //print("response: \(responseDictionary)")
                    
                    self.book = responseDictionary["items"] as? [NSDictionary]
                    print(self.book)
                    self.parseDictionary()
                }
            }
        })
        task.resume()
    }
    
    func saveIsbn(withIsbn isbn :String?){
        //do string manilupation to delte "-" or "space" to leave just numbers
        self.isbn = isbn
    }
    
    func isValidIsbn(withIsbn isbn: String?) -> Bool {
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
            self.imageUrl = NSURL(string: thumbnail!)!
            //self.previewCover!.setImageWithURL(imageUrl!)
            
            //author
            let authors = volumeInfo?["authors"]
            self.author = authors![0] as? String
            
            //isbn
            let industryIdentifiers = volumeInfo?["industryIdentifiers"]
            //isbn10
            let identifier10 = industryIdentifiers![0] as! NSDictionary
            self.isbn10 = identifier10["identifier"] as? String
            //isbn13
            let identifier13 = industryIdentifiers![1] as! NSDictionary
            self.isbn13 = identifier13["identifier"] as? String
            
            print(author)
            print(isbn10)
            print(self.title)
            
            NSNotificationCenter.defaultCenter().postNotificationName("Google", object: nil)
            
        }
        else{
            print("Error: no book")
        }
    }
    
    
    
}
