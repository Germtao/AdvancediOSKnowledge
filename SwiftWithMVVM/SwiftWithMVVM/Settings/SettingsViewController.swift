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
        
        var viewModel: SettingsRepresentable?
        
        switch section {
        case .time:
            guard let timeNotation = TimeNotation(rawValue: indexPath.row) else { fatalError("Unexpected Time Notation") }
            viewModel = SettingsTimeViewModel(timeNotation: timeNotation)
        case .units:
            guard let unitsNotation = UnitsNotation(rawValue: indexPath.row) else { fatalError("Unexpected Units Notation") }
            viewModel = SettingsUnitsViewModel(unitsNotation: unitsNotation)
        case .temperature:
            guard let temperatureNotation = TemperatureNotation(rawValue: indexPath.row) else { fatalError("Unexpected Temperature Notation") }
            viewModel = SettingsTemperatureViewModel(temperatureNotation: temperatureNotation)
        }
        
        if let viewModel = viewModel {
            cell.configureCell(withViewModel: viewModel)
        }

        return cell
    }
}
