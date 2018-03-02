//
//  Message.swift
//  MyChat
//
//  Created by Michal on 01.03.18.
//  Copyright © 2018 Michal. All rights reserved.
//

import Foundation

class Message {
    let text: String
    let sender: User
    
    var dictionaryValue: NSDictionary {
        get {
            return ["text" : text, "sender" : ["name" : sender.name]]
        }
    }
    
    init(text: String, sender: User) {
        self.text = text
        self.sender = sender
    }
    
    init(_ value: [String:AnyObject]) {
        text = value["text"] as! String
        sender = User(name: (value["sender"] as! [String:AnyObject])["name"] as! String)
    }
    
    
}
