//
//  DataManager.swift
//  MyChat
//
//  Created by Michal on 02.03.18.
//  Copyright © 2018 Michal. All rights reserved.
//

import Foundation
import FirebaseDatabase

protocol DataManagerDelegate : NSObjectProtocol {
    func dataManagerDidReceiveNewData(_ manager: DataManager)
}

class DataManager {
    
    weak var delegate : DataManagerDelegate?
    var messages = [Message]()

    
    init(_ delegate: DataManagerDelegate? = nil) {
        self.delegate = delegate

        //delegate?.dataManagerDidReceiveNewData(self)
        watchForUpdates()
    }
    
    func sendMessage(_ msg : Message) {
        let trigger = Database.database().reference(withPath: "Messages").childByAutoId()
        trigger.setValue(msg.dictionaryValue)
        
        
        
        messages.insert(msg, at: 0)
        delegate?.dataManagerDidReceiveNewData(self)
    }
    
    private func watchForUpdates() {
        Database.database().reference(withPath: "Messages").observe(.value) {
            (snapshot) in
            self.messages = [Message]()
            for obj in snapshot.children.allObjects {
                let data = obj as! DataSnapshot
                let jsonResult = data.value
                self.messages.insert(Message(jsonResult as! [String: AnyObject]), at:0)

            }
            
            self.delegate?.dataManagerDidReceiveNewData(self)
        }
    }
    

    
}
