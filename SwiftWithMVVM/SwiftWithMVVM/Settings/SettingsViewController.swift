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
            guard let timeNotation = TimeNotation(rawValue: indexPath.row) else { fatalError("Unexpected Time Notation") }
            let viewModel = SettingsTimeViewModel(timeNotation: timeNotation)
            cell.textLabel?.text = viewModel.text
            cell.accessoryType = viewModel.accessoryType
        case .units:
            guard let unitsNotation = UnitsNotation(rawValue: indexPath.row) else { fatalError("Unexpected Units Notation") }
            let viewModel = SettingsUnitsViewModel(unitsNotation: unitsNotation)
            cell.textLabel?.text = viewModel.text
            cell.accessoryType = viewModel.accessoryType
        case .temperature:
            guard let temperatureNotation = TemperatureNotation(rawValue: indexPath.row) else { fatalError("Unexpected Temperature Notation") }
            let viewModel = SettingsTemperatureViewModel(temperatureNotation: temperatureNotation)
            cell.textLabel?.text = viewModel.text
            cell.accessoryType = viewModel.accessoryType
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
