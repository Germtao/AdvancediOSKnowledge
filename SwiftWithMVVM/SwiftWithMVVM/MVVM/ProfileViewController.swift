//
//  ProfileViewController.swift
//  SwiftWithMVVM
//
//  Created by QDSG on 2019/4/29.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var viewModel: ProfileViewModel!
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: profileDefaultTableViewCell)
        tableView.register(UINib(nibName: "ProfileSwitchTableViewCell", bundle: nil), forCellReuseIdentifier: profileSwitchTableViewCell)
    }
}

extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return ProfileSection.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = ProfileSection(rawValue: section) else { return 1 }
        switch section {
        case .WarmUp:
            return viewModel.numberOfRows(forSegmentOfType: .WarmUp)
        case .CoolDown:
            return viewModel.numberOfRows(forSegmentOfType: .CoolDown)
        default: return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = ProfileSection(rawValue: indexPath.section) else { return UITableViewCell() }
        switch section {
        case .Time:
            return cellForTimeSection(forRowAt: indexPath)
        case .WarmUp:
            return cellForWarmUpSection(forRowAt: indexPath)
        case .CoolDown:
            return cellForCoolDownSection(forRowAt: indexPath)
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = ProfileSection(rawValue: section) else { return "" }
        return section.sectionTitle()
    }
}

private let profileDefaultTableViewCell = "profileDefaultTableViewCell"
private let profileSwitchTableViewCell = "profileSwitchTableViewCell"
extension ProfileViewController {
    private func cellForTimeSection(forRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: profileDefaultTableViewCell, for: indexPath) as? ProfileTableViewCell else { return UITableViewCell() }
        cell.detailTextLabel?.text = ""
        cell.textLabel?.text = viewModel.timeForProfile()
        return cell
    }
    
    private func cellForWarmUpSection(forRowAt indexPath: IndexPath) -> UITableViewCell {
        var result = UITableViewCell()
        
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: profileSwitchTableViewCell, for: indexPath) as? ProfileSwitchTableViewCell {
                cell.mainLabel.text = "Enable"
                cell.switchControl.isOn = viewModel.segmentEnabled(ofType: .WarmUp)
                
                cell.switchControlHandle = { sender in
                    self.viewModel.setSegment(ofType: .WarmUp, enabled: sender.isOn)
                    
                    if sender.isOn {
                        self.tableView.insertRows(at: [IndexPath(row: 1, section: indexPath.section)], with: .top)
                    } else {
                        self.tableView.deleteRows(at: [IndexPath(row: 1, section: indexPath.section)], with: .top)
                    }
                }
                
                result = cell
            }
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: profileDefaultTableViewCell, for: indexPath) as? ProfileTableViewCell {
                cell.detailTextLabel?.text = ""
                cell.textLabel?.text = viewModel.timeForSegment(ofType: .WarmUp)
                result = cell
            }
        }
        return result
    }
    
    private func cellForCoolDownSection(forRowAt indexPath: IndexPath) -> UITableViewCell {
        var result = UITableViewCell()
        
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: profileSwitchTableViewCell, for: indexPath) as? ProfileSwitchTableViewCell {
                cell.mainLabel.text = "Enabled"
                cell.switchControl.isOn = viewModel.segmentEnabled(ofType: .CoolDown)
                
                cell.switchControlHandle = { (sender) in
                    var indexPaths = [IndexPath]()
                    
                    let currentNumberOfRows = self.viewModel.numberOfRows(forSegmentOfType: .CoolDown)
                    self.viewModel.setSegment(ofType: .CoolDown, enabled: sender.isOn)
                    let newNumberOfRows = self.viewModel.numberOfRows(forSegmentOfType: .CoolDown)
                    
                    if sender.isOn {
                        for row in currentNumberOfRows..<newNumberOfRows {
                            indexPaths.append(IndexPath(row: row, section: indexPath.section))
                        }
                        
                        self.tableView.insertRows(at: indexPaths, with: .top)
                    } else {
                        for row in newNumberOfRows..<currentNumberOfRows {
                            indexPaths.append(IndexPath(row: row, section: indexPath.section))
                        }
                        
                        self.tableView.deleteRows(at: indexPaths, with: .top)
                    }
                }
                
                result = cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: profileDefaultTableViewCell, for: indexPath) as? ProfileTableViewCell {
                cell.detailTextLabel?.text = ""
                cell.textLabel?.text = viewModel.timeForSegment(ofType: .CoolDown)
                
                result = cell
            }
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: profileSwitchTableViewCell, for: indexPath) as? ProfileSwitchTableViewCell {
                cell.mainLabel.text = "Bells"
                cell.switchControl.isOn = viewModel.soundEnabled(ofType: .Begin, forSegmentType: .CoolDown)
                
                cell.switchControlHandle = { sender in
                    var indexPaths = [IndexPath]()
                    
                    let currentNumberOfRows = self.viewModel.numberOfRows(forSegmentOfType: .CoolDown)
                    self.viewModel.setSound(ofType: .Begin, enabled: sender.isOn, forSegmentType: .CoolDown)
                    let newNumberOfRows = self.viewModel.numberOfRows(forSegmentOfType: .CoolDown)
                    
                    if sender.isOn {
                        for row in currentNumberOfRows..<newNumberOfRows {
                            indexPaths.append(IndexPath(row: row, section: indexPath.section))
                        }
                        
                        self.tableView.insertRows(at: indexPaths, with: .top)
                    } else {
                        for row in newNumberOfRows..<currentNumberOfRows {
                            indexPaths.append(IndexPath(row: row, section: indexPath.section))
                        }
                        
                        self.tableView.deleteRows(at: indexPaths, with: .top)
                    }
                }
                
                result = cell
            }
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: profileDefaultTableViewCell, for: indexPath) as? ProfileTableViewCell {
                cell.detailTextLabel?.text = "Name"
                cell.textLabel?.text = "What's wrong with u?"
                
                result = cell
            }
        }
        return result
    }
}
