//
//  UserViewController.swift
//  CoreDataDemo
//
//  Created by QDSG on 2019/5/5.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    var user: User?
    
    @IBOutlet weak var firstTF: UITextField!
    @IBOutlet weak var lastTF: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func save() {
        user?.first = firstTF.text
        user?.last = lastTF.text
        
        dismiss(animated: true, completion: nil)
    }

}
