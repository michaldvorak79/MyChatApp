//
//  ChatViewController.swift
//  MyChat
//
//  Created by Michal on 01.03.18.
//  Copyright © 2018 Michal. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, DataManagerDelegate {
    
    var me: User!
    var dataManager : DataManager!
    
    @IBOutlet var btnSend : UIButton!
    @IBOutlet var txtMessage : UITextField!
    @IBOutlet var tableView : UITableView!
    @IBOutlet var tableViewBottomConstraint : NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataManager = DataManager(self)

        // Do any additional setup after loading the view.
        self.title = me.name
        checkButton()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendMessage()
        checkButton()
        return true
    }
    
    @IBAction func sendMessage() {
        if let msg = txtMessage.text {
            print(msg)
            dataManager.sendMessage(Message(text: msg, sender: me))
            txtMessage.text = ""
            txtMessage.resignFirstResponder()
        }
    }
    
    @IBAction func checkButton() {
        if let msgLen = txtMessage.text?.count {
            btnSend.isEnabled = msgLen > 0
        } else {
            btnSend.isEnabled = false
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ret = tableView.dequeueReusableCell(withIdentifier: "MyChatTableViewCell", for: indexPath) as! MyChatTableViewCell
        let msg = dataManager.messages[indexPath.row]
        ret.lblName.text = msg.sender.name
        ret.lblMessage.text = msg.text
        return ret
    }
    
    func dataManagerDidReceiveNewData(_ manager: DataManager) {
        tableView.reloadData()
    }

    //MARK: Keyboard handler
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: Notification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: Notification.Name.UIKeyboardWillShow, object: nil)
    }
    
    func adjustKeyboardShow(_ open: Bool, notification: Notification) {
        let userInfo = notification.userInfo ?? [:]
        let keyboardFrame = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        //let height = (keyboardFrame.height + 20) * (open ? 1 : -1)
        
        //tableView.contentInset.bottom += height
        //tableView.scrollIndicatorInsets.bottom += height
        tableViewBottomConstraint.constant = open ? keyboardFrame.height : 0
        UIView.animate(withDuration: 0.75) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillAppear(_ notification: Notification) {
        adjustKeyboardShow(true, notification: notification)
    }
    @objc func keyboardWillDisappear(_ notification: Notification) {
        adjustKeyboardShow(false, notification: notification)
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }

}
