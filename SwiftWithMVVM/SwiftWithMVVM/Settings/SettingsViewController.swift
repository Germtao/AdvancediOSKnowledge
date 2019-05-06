//
//  SettingsViewController.swift
//  SwiftWithMVVM
//
//  Created by QDSG on 2019/5/6.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsSection.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = SettingsSection(rawValue: section) else { fatalError("Unexpected Section") }
        return section.numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = SettingsSection(rawValue: indexPath.section) else { fatalError("Unexpected Section") }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.reuseIdentifier, for: indexPath) as? SettingsTableViewCell else { fatalError("Unexpected Settings Table View Cell") }
        
        switch section {
        case .time:
            cell.textLabel?.text = (indexPath.row == 0) ? "12 Hours" : "24 Hours"
            
            let timeNotation = UserDefaults.timeNotation()
            if indexPath.row == timeNotation.rawValue {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        case .units:
            cell.textLabel?.text = (indexPath.row == 0) ? "Imperial" : "Metric"
            
            let unitsNotation = UserDefaults.unitsNotation()
            if indexPath.row == unitsNotation.rawValue {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            
        case .temperature:
            cell.textLabel?.text = (indexPath.row == 0) ? "Fahrenheit" : "Celcius"
            
            let temperatureNotation = UserDefaults.temperatureNotation()
            if indexPath.row == temperatureNotation.rawValue {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        }

        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let section = SettingsSection(rawValue: indexPath.section) else { fatalError("Unexpected Section") }
//
//        switch section {
//        case .time:
//            indexPath.row == 0 ? UserDefaults.set(timeNotation: TimeNotation.twelveHour) :
//        default:
//            <#code#>
//        }
//    }
}
