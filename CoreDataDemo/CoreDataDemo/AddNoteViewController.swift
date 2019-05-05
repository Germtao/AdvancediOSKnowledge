//
//  AddNoteViewController.swift
//  CoreDataDemo
//
//  Created by QDSG on 2019/5/5.
//  Copyright © 2019 unitTao. All rights reserved.
//

import UIKit
import CoreData

class AddNoteViewController: UIViewController {
    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var contentTV: UITextView!
    
    var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func cancel() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func save() {
        if let managedObjectContext = user.managedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Note", in: managedObjectContext) {
            
            let note = Note(entity: entity, insertInto: managedObjectContext)
            note.title = titleTF.text
            note.content = contentTV.text
            note.user = user
        }
        
        navigationController?.popViewController(animated: true)
    }

}
