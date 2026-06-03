//
//  TaskDetailViewController.swift
//  TaskPoint
//
//  Created by Ahmet CILINGIR on 03.06.26.
//

import CoreData
import UIKit

class TaskDetailViewController: UIViewController {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var priorityLabel: UILabel!
    @IBOutlet weak var isCompletedLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!

    var selectedId = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        //print(selectedId + " selected")

        // Do any additional setup after loading the view.
        getSelectedData()
    }

    func getSelectedData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(
            entityName: "TaskEntity"
        )
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(
            format: "taskUUID == %@",
            selectedId
        )

        do {
            let results = try context.fetch(fetchRequest)
            for result in results as! [NSManagedObject] {
                if let iconName = result.value(forKey: "taskIconName")
                    as? String
                {
                    iconImageView.image = UIImage(systemName: iconName)
                }
                if let title = result.value(forKey: "taskTitle") as? String {
                    titleLabel.text = title
                }
                if let description = result.value(forKey: "taskDescription")
                    as? String
                {
                    descriptionLabel.text = description
                }
                if let date = result.value(forKey: "taskDate") as? String {
                    //iconImageView.image = UIImage(systemName: iconName)

                    if let time = result.value(forKey: "taskTime") as? String {
                        dateLabel.text = date + " - " + time
                    }
                }
                if let isCompleted = result.value(forKey: "taskIsCompleted")
                    as? Bool
                {

                    switch isCompleted {
                    case true:
                        isCompletedLabel.text = "Completed"
                        isCompletedLabel.backgroundColor = .systemCyan
                        isCompletedLabel.textColor = .white
                    case false:
                        isCompletedLabel.text = "Activ"
                        isCompletedLabel.backgroundColor = .systemGray
                        isCompletedLabel.textColor = .white
                    /*
                     default:
                        isCompletedLabel.text = "-"
                        break
                     */
                    }
                }
                if let location = result.value(forKey: "taskLocation")
                    as? String
                {
                    locationLabel.text = location
                }
                if let priortiy = result.value(forKey: "taskPriority")
                    as? String
                {
                    switch priortiy
                    {
                    case "low":
                        self.priorityLabel.text = priortiy
                        self.priorityLabel.backgroundColor = .systemGreen
                        self.priorityLabel.textColor = .white
                    case "medium":
                        self.priorityLabel.text = priortiy
                        self.priorityLabel.backgroundColor = .systemOrange
                        self.priorityLabel.textColor = .white
                    case "high":
                        self.priorityLabel.text = priortiy
                        self.priorityLabel.backgroundColor = .systemRed
                        self.priorityLabel.textColor = .white
                    default:
                        break
                    }

                }
                if let taskNote = result.value(forKey: "taskNotes") as? String {
                    notesLabel.text = taskNote
                }
            }

        } catch {
            print("TaskDetailFetch Error")
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
