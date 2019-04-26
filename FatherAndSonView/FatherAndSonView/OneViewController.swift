//
//  OneViewController.swift
//  FatherAndSonView
//
//  Created by QDSG on 2019/4/26.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class OneViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("One View Controller Will Appear!")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("One View Controller Will Disappear!")
    }

}
