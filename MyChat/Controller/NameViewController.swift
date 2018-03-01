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
    @IBAction func startClick() {
        print("start - user name = " + txtName.text!)
    }
    
    @IBAction func checkInput() {
        btnStart.isEnabled = txtName.text!.count > 2
    }
    
}

