//
//  SettingsRepresentable.swift
//  SwiftWithMVVM
//
//  Created by QDSG on 2019/5/6.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

protocol SettingsRepresentable {
    var text: String { get }
    var accessoryType: UITableViewCell.AccessoryType { get }
}
