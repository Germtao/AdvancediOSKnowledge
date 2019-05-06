//
//  SettingsTemperatureViewModel.swift
//  SwiftWithMVVM
//
//  Created by QDSG on 2019/5/6.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

enum TemperatureNotation: Int {
    case fahrenheit
    case celcius
}

struct SettingsTemperatureViewModel: SettingsRepresentable {
    let temperatureNotation: TemperatureNotation
    
    var text: String {
        switch temperatureNotation {
        case .fahrenheit: return "Fahrenheit"
        case .celcius: return "Celcius"
        }
    }
    
    var accessoryType: UITableViewCell.AccessoryType {
        if UserDefaults.temperatureNotation() == temperatureNotation {
            return .checkmark
        } else {
            return .none
        }
    }
}
