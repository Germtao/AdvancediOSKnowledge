//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by QDSG on 2019/5/5.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var managedObjectContext: NSManagedObjectContext?

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
    }
}

// MARK: - 通知监听事件
extension ViewController {
    @objc private func managedObjectContextObjectsDidChange(_ notification: Notification) {
        
    }
    
    @objc private func managedObjectContextWillSave() {
        
    }
    
    @objc private func managedObjectContextDidSave() {
        
    }
}

