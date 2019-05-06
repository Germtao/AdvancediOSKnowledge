//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by QDSG on 2019/5/5.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController {
    
    private let noteCell = "NoteCell"
    
    var user: User?
    var managedObjectContext: NSManagedObjectContext?
    
    lazy var resultsController: NSFetchedResultsController<NSFetchRequestResult> = {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
        
        let controller = NSFetchedResultsController(fetchRequest: request,
                                                    managedObjectContext: self.managedObjectContext!,
                                                    sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let managedObjectContext = managedObjectContext {
            // Add Observer
            let notificationCenter = NotificationCenter.default
            notificationCenter.addObserver(self,
                                           selector: #selector(managedObjectContextObjectsDidChange(_:)),
                                           name: NSNotification.Name.NSManagedObjectContextObjectsDidChange,
                                           object: managedObjectContext)
            notificationCenter.addObserver(self,
                                           selector: #selector(managedObjectContextWillSave),
                                           name: NSNotification.Name.NSManagedObjectContextWillSave,
                                           object: managedObjectContext)
            notificationCenter.addObserver(self,
                                           selector: #selector(managedObjectContextDidSave),
                                           name: NSNotification.Name.NSManagedObjectContextDidSave,
                                           object: managedObjectContext)
        }
        
        if let currentUser = fetchUser() {
            user = currentUser
        } else if let newUser = createUser() {
            user = newUser
        }
        
        do {
            try resultsController.performFetch()
        } catch {
            print("Unable to Fetch User")
            print(error, error.localizedDescription)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UserSegue" {
            if let userVc = segue.destination as? UserViewController {
                userVc.user = user
            }
        } else if segue.identifier == "AddNoteSegue" {
            if let addNoteVc = segue.destination as? AddNoteViewController {
                addNoteVc.user = user
            }
        }
    }
}

extension ViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath, let cell = tableView.cellForRow(at: indexPath) {
                configureCell(cell, atIndexPath: indexPath)
            }
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        default: break
        }
    }
}

// MARK: - 数据源&代理
extension ViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = resultsController.sections {
            return sections.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = resultsController.sections {
            return sections[section].numberOfObjects
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: noteCell, for: indexPath)
        configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let note = resultsController.object(at: indexPath) as? Note {
                managedObjectContext?.delete(note)
            }
        }
    }
}

// MARK: - 通知监听事件
extension ViewController {
    @objc private func managedObjectContextObjectsDidChange(_ notification: Notification) {
        guard let userinfo = notification.userInfo else { return }
        
        if let inserts = userinfo[NSInsertedObjectsKey] as? Set<NSManagedObject>,
            inserts.count > 0 {
            print("--- INSERTS ---")
            print(inserts)
            print("+++++++++++++++")
        }
        
        if let updates = userinfo[NSUpdatedObjectsKey] as? Set<NSManagedObject>,
            updates.count > 0 {
            print("--- UPDATES ---")
            for update in updates {
                print(update.changedValues())
            }
            print("+++++++++++++++")
        }
        
        if let deletes = userinfo[NSDeletedObjectsKey] as? Set<NSManagedObject>,
            deletes.count > 0 {
            print("--- DELETES ---")
            print(deletes)
            print("+++++++++++++++")
        }
    }
    
    @objc private func managedObjectContextWillSave() {
        
    }
    
    @objc private func managedObjectContextDidSave() {
        
    }
}

// MARK: - Helpers Method
extension ViewController {
    /// 取 user
    private func fetchUser() -> User? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        do {
            if let result = try managedObjectContext?.fetch(fetchRequest) as? [User], result.count > 0, let user = result.first {
                return user
            }
        } catch {
            print("Unable to Fetch User")
            print(error, error.localizedDescription)
        }
        
        return nil
    }
    
    /// 创建 user
    private func createUser() -> User? {
        guard let managedObjectContext = managedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "User", in: managedObjectContext) else { return nil }
        
        let result = User(entity: entity, insertInto: managedObjectContext)
        
        result.first = "Bart"
        result.last = "Jacobs"
        
        return result
    }
    
    /// 配置 cell
    private func configureCell(_ cell: UITableViewCell, atIndexPath indexPath: IndexPath) {
        if let note = resultsController.object(at: indexPath) as? Note {
            cell.textLabel?.text = note.title
            cell.detailTextLabel?.text = note.content
        }
    }
}
