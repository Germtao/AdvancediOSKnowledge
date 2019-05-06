//
//  SettingsTimeViewModel.swift
//  SwiftWithMVVM
//
//  Created by QDSG on 2019/5/6.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

enum TimeNotation: Int {
    case twelveHour
    case twentyFourHour
}

struct SettingsTimeViewModel {
    let timeNotation: TimeNotation
    
    var text: String {
        switch timeNotation {
        case .twelveHour: return "12小时"
        case .twentyFourHour: return "24小时"
        }
    }
    
    var accessoryType: UITableViewCell.AccessoryType {
        if UserDefaults.timeNotation() == timeNotation {
            return .checkmark
        } else {
            return .none
        }
    }
}

enum SettingsSection: Int {
    case time, units, temperature
    
    static var count: Int {
        return SettingsSection.temperature.rawValue + 1
    }
    
    var numberOfRows: Int {
        return 2
    }
}
