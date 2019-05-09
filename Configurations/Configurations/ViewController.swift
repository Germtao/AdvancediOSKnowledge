//
//  ViewController.swift
//  Configurations
//
//  Created by QDSG on 2019/5/9.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let configuration = Configuration()
        print(configuration.environment.baseURL)
    }
}

