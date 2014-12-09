//
//  ViewController.swift
//  VMFloatLabeled
//
//  Created by Jimmy Jose on 08/12/14.
//  Copyright (c) 2014 Varshyl Mobile Pvt. Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var txtFirstName:VMFloatLabelTextField?
    @IBOutlet var txtLastName:VMFloatLabelTextField?
    @IBOutlet var txtViewDescription:VMFloatLabelTextView?
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //txtFirstName?.placeholder = "placeholder text"
        txtViewDescription?.placeholder = "Textview with placeholder"
        txtViewDescription?.placeholderLabel.text = "set now"
        txtViewDescription?.layoutSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

