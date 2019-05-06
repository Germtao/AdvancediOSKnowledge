//
//  SettingsUnitsViewModel.swift
//  SwiftWithMVVM
//
//  Created by QDSG on 2019/5/6.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

enum UnitsNotation: Int {
    case imperial
    case metric
}

struct SettingsUnitsViewModel {
    let unitsNotation: UnitsNotation
    
    var text: String {
        switch unitsNotation {
        case .imperial: return "Imperial"
        case .metric: return "Metric"
        }
    }
    
    var accessoryType: UITableViewCell.AccessoryType {
        if UserDefaults.unitsNotation() == unitsNotation {
            return .checkmark
        } else {
            return .none
        }
    }
}
