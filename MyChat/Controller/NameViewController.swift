//
//  ViewController.swift
//  MyChat
//
//  Created by Michal on 01.03.18.
//  Copyright © 2018 Michal. All rights reserved.
//

import UIKit

class NameViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet var txtName: UITextField!
    @IBOutlet var btnStart: UIButton!
    
    //MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("viewDidLoad")
        if let userName = loadName() {
            txtName.text = userName
        }
        checkInput()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("viewDidAppear")
    }


    //MARK: Actions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let destination = segue.destination as? ChatViewController, let userName = txtName.text {
            destination.me = User(name: userName)
            txtName.resignFirstResponder()
            storeName(userName)

        }
    }
    
    @IBAction func checkInput() {
        btnStart.isEnabled = txtName.text!.count > 2
    }
    
    func storeName(_ name: String) {
        UserDefaults.standard.set(name, forKey: "name")
    }
    
    func loadName() -> String? {
        return UserDefaults.standard.string(forKey: "name")
    }
    
}

