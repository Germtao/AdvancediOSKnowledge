//
//  ProfileSwitchTableViewCell.swift
//  SwiftWithMVVM
//
//  Created by QDSG on 2019/4/29.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class ProfileSwitchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var switchControl: UISwitch!
    
    var switchControlHandle: ((_ sender: UISwitch) -> Void)!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func switchControlClicked(_ sender: UISwitch) {
        switchControlHandle(sender)
    }
}
