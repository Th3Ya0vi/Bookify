//
//  ChatViewController.swift
//  Bookify
//
//  Created by Neal Patel on 4/6/16.
//  Copyright © 2016 Bookify. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var messageContent: UITextView!
    
    var usernames: NSArray?
    var messages: NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.chatTableView.delegate = self
        self.chatTableView.dataSource = self
    }
    
    override func viewDidAppear(animated: Bool) {
        onTimer()
    }
    
    func onTimer() {
        NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: #selector(ChatViewController.onTimer), userInfo: nil, repeats: true)
        //        print("running onTimer")
        // construct query
        let query = PFQuery(className: "Messages")
        
        query.findObjectsInBackgroundWithBlock { (message: [PFObject]?, error: NSError?) -> Void in
            if let message = message {
                self.messages = message
                self.chatTableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }
        let userQuery = PFQuery(className: "Messages")
        userQuery.findObjectsInBackgroundWithBlock { (user: [PFObject]?, error: NSError?) in
            if let user = user {
                self.usernames = user
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let messages = messages {
            return messages.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = chatTableView.dequeueReusableCellWithIdentifier("chat", forIndexPath: indexPath) as! MessagesTableViewCell
        print("these are the messages: \(messages)")
        cell.messageHolder.text = messages?[indexPath.row]["message"] as? String
        cell.userSendingMessage.text = messages?[indexPath.row]["username"] as? String
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendMessage(sender: AnyObject) {
        if messageContent.text != nil {
            Post.postMessage(messageContent.text, withCompletion: { (success: Bool, error: NSError?) in
                if success {
                    print("successfully posted message")
                    self.chatTableView.reloadData()
                } else {
                    print(error?.localizedDescription)
                }
            })
        }
    }
    
    @IBAction func exitChat(sender: AnyObject) {
        self.performSegueWithIdentifier("exitChat", sender: nil)
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
