//
//  DataManager.swift
//  MyChat
//
//  Created by Michal on 02.03.18.
//  Copyright © 2018 Michal. All rights reserved.
//

import Foundation

protocol DataManagerDelegate : NSObjectProtocol {
    func dataManagerDidReceiveNewData(_ manager: DataManager)
}

class DataManager {
    
    weak var delegate : DataManagerDelegate?
    var messages = [Message]()

    
    init(_ delegate: DataManagerDelegate? = nil) {
        mockData()
        self.delegate = delegate

        //delegate?.dataManagerDidReceiveNewData(self)
    }
    
    func sendMessage(_ text: String, sender: User) {
        messages.insert(Message(text: text, sender: sender), at: 0)
        delegate?.dataManagerDidReceiveNewData(self)
    }
    
    //MARK: Debug
    private func mockData() {
        messages.append(Message(text: "Testovací zpráva 1", sender:User(name: "Adam")))
        messages.append(Message(text: "Testovací zpráva 2", sender:User(name: "Barbora")))
        messages.append(Message(text: "Testovací zpráva 3", sender:User(name: "Cyril")))
    }
    

    
}
