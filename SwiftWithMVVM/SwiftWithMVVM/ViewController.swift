//
//  ViewController.swift
//  SwiftWithMVVM
//
//  Created by QDSG on 2019/4/29.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

private let segueProfileViewController = "segueProfileViewController"

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueProfileViewController {
            if let vc = segue.destination as? ProfileViewController {
                vc.viewModel = ProfileViewModel(withProfile: Profile())
            }
        }
    }
}

