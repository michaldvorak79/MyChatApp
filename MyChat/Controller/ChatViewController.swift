//
//  ChatViewController.swift
//  MyChat
//
//  Created by Michal on 01.03.18.
//  Copyright © 2018 Michal. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource {
    
    var me: User!
    var messages = [Message]()
    
    @IBOutlet var btnSend : UIButton!
    @IBOutlet var txtMessage : UITextField!
    @IBOutlet var tableView : UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = me.name
        checkButton()
        mockData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendMessage()
        return true
    }
    
    @IBAction func sendMessage() {
        if let msg = txtMessage.text {
            print(msg)
            txtMessage.text = ""
            txtMessage.resignFirstResponder()
        }
    }
    
    @IBAction func checkButton() {
        if let msgLen = txtMessage.text?.count {
            btnSend.isEnabled = msgLen > 0
        }
    }
    
    
    //MARK: Debug
    func mockData() {
        messages.append(Message(text: "Testovací zpráva 1", sender:User(name: "Adam")))
        messages.append(Message(text: "Testovací zpráva 2", sender:User(name: "Barbora")))
        messages.append(Message(text: "Testovací zpráva 3", sender:User(name: "Cyril")))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ret = tableView.dequeueReusableCell(withIdentifier: "MyChatTableViewCell", for: indexPath) as! MyChatTableViewCell
        let msg = messages[indexPath.row]
        ret.lblName.text = msg.sender.name
        ret.lblMessage.text = msg.text
        return ret
    }

}
