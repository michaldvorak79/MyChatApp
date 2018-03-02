//
//  DataManager.swift
//  MyChat
//
//  Created by Michal on 02.03.18.
//  Copyright © 2018 Michal. All rights reserved.
//

import Foundation
import FirebaseDatabase
import Alamofire

protocol DataManagerDelegate : NSObjectProtocol {
    func dataManagerDidReceiveNewData(_ manager: DataManager)
    func dataManagerError(_ msg : String)
}

class DataManager {
    
    weak var delegate : DataManagerDelegate?
    var messages = [Message]()

    
    init(_ delegate: DataManagerDelegate? = nil) {
        self.delegate = delegate

        //delegate?.dataManagerDidReceiveNewData(self)
        watchForUpdates()
        getDataFromApi()
    }
    
    func sendMessage(_ msg : Message) {
        let trigger = Database.database().reference(withPath: "Messages").childByAutoId()
        trigger.setValue(msg.dictionaryValue)
        
        
        
        //messages.insert(msg, at: 0)
        //delegate?.dataManagerDidReceiveNewData(self)
    }
    
    private func watchForUpdates() {
        Database.database().reference(withPath: "Messages").observe(.childAdded) {
            (snapshot) in
            //self.messages = [Message]()
            if let jsonResult = snapshot.value as? [String: AnyObject],
                let msg = Message(jsonResult) {
                    self.messages.insert(msg, at:0)
                }
            
            self.delegate?.dataManagerDidReceiveNewData(self)
        }
    }
    
    //MARK: network API requests
    func getDataFromApi() {
        Alamofire.request(URL(string: "http://private-6c237c-testchatapp.apiary-mock.com/messages")!, method: .get).responseJSON {(response) in
            switch response.result {
            case .success(let JSON) :
                print ("Success with JSON: \(JSON)")
                if let data = JSON as? [[String: AnyObject]] {
                    for obj in data {
                        if let msg = Message(obj) {
                            self.messages.insert(msg, at: 0)
                            print("Inserted message: \(obj)")
                        }
                    }
                }
                self.delegate?.dataManagerDidReceiveNewData(self)
            case .failure(let error) :
                print("Error with code: \(error)")
                self.delegate?.dataManagerError("Error downloading messages: \(error.localizedDescription)")
            }
            
        }
    }
    

    
}
