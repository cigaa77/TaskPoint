//
//  AddTaskViewController.swift
//  TaskPoint
//
//  Created by Ahmet CILINGIR on 30.05.26.
//

import UIKit
import CoreData

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextField!
    @IBOutlet weak var dueDatePicker: UITextField!
    @IBOutlet weak var dueTimePicker: UITextField!
    // @IBOutlet weak var dueLocationPicker: UITextField!
    @IBOutlet weak var priorityPicker: UISegmentedControl!
    @IBOutlet weak var notesTextField: UITextView!
    // @IBOutlet weak var isCompletedSwitch:
    // @IBOutlet weak var iconName:

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationItem.title = "Add Task"
        
        let addButton = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveClicked))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func saveClicked() {
        //navigationController?.popViewController(animated: true)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newTask = NSEntityDescription.insertNewObject(forEntityName: "TaskEntity", into: context)
        
        newTask.setValue(titleTextField.text!, forKey: "taskTitle")
        newTask.setValue(descriptionTextView.text!, forKey: "taskDescription")
        newTask.setValue(dueDatePicker.text!, forKey: "taskDate")
        newTask.setValue(dueTimePicker.text!, forKey: "taskTime")
        switch priorityPicker.selectedSegmentIndex {
            case 0:
            //print("0")
            newTask.setValue("low", forKey: "taskPriority")
            break
        case 1:
            //print("1")
            newTask.setValue("medium", forKey: "taskPriority")
            break
        case 2:
            //print("2")
            newTask.setValue("high", forKey: "taskPriority")
            break
        default:
        print("default")
            break
        }
        newTask.setValue(notesTextField.text, forKey: "taskNotes")
        newTask.setValue(false, forKey: "taskIsCompleted")
        newTask.setValue("cart.fill", forKey: "taskIconName")
        newTask.setValue("Rheinau, Germany", forKey: "taskLocation")
        newTask.setValue(UUID(), forKey: "taskUUID")
        
        do {
            try context.save()
            print("CoreDate Save Success!")
            navigationController?.popViewController(animated: true)
        }catch {
            print("CoreDate Save Failed")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
