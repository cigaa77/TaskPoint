//
//  TaskListViewController.swift
//  TaskPoint
//
//  Created by Ahmet CILINGIR on 30.05.26.
//

import UIKit
import CoreData

class TaskListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    /*
    var mockTaskArray = [
        MockTaskList(
            iconName: "book.fill",
            title: "German Study",
            description: "B2 preparation",
            date: "30 May 2026",
            time: "18:00",
            location: "Rheinau, Germany",
            priority: "High",
            notes: "Practice speaking and vocabulary",
            isCompleted: false
        ),
        MockTaskList(
            iconName: "cart.fill",
            title: "Grocery Shopping",
            description: "Weekly groceries",
            date: "01 June 2026",
            time: "19:30",
            location: "Mannheim, Germany",
            priority: "Medium",
            notes: "Buy vegetables and milk",
            isCompleted: true
        )
    ]
    */
    
    var taskListArray = [MockTaskList]()
    var idArrayList = [UUID]()
    
    var sendedId = ""
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        /*
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: UIBarButtonItem.Style.plain, target: self, action: #selector(addNavigationButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "asd", style: UIBarButtonItem.Style.prominent, target: self, action: #selector(addNavigationButton))
        */

        let addNavigationButtomItem = UIBarButtonItem(
            title: "+",
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(addNavigationButton)
        )
        let addNavigationButtomItem2 = UIBarButtonItem(
            title: "Exit",
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(exitNavigationButton)
        )

        navigationItem.rightBarButtonItems = [
            addNavigationButtomItem, addNavigationButtomItem2,
        ]

        navigationItem.title = "My Tasks"

        /*
        let titleLabel = UILabel()
        titleLabel.text = "My Tasks"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = .systemPurple
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        */
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getFromCoreData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        getFromCoreData()
    }

    @objc func addNavigationButton() {
        performSegue(withIdentifier: "toAddTaskViewController", sender: nil)
    }

    @objc func exitNavigationButton() {
        performSegue(withIdentifier: "toViewController", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)  as! CustomTaskTableViewCell
        let task = taskListArray[indexPath.row]
        cell.iconImageView.image = UIImage(systemName: task.iconName)
        cell.titleLabel.text = task.title
        cell.descriptionLabel.text = task.description
        cell.dateLabel.text = task.date
        cell.timeLabel.text = task.time
        cell.isCompletedLabel.text = task.priority
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,commit editingStyle: UITableViewCell.EditingStyle,forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext

            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(
                entityName: "TaskEntity"
            )

            let uuidString = idArrayList[indexPath.row].uuidString

            fetchRequest.predicate = NSPredicate(format: "taskUUID == %@",uuidString)
            fetchRequest.returnsObjectsAsFaults = false

            do {
                let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        if let id = result.value(forKey: "taskUUID") as? UUID {
                            if id == idArrayList[indexPath.row] {
                                context.delete(result)
                                taskListArray.remove(at: indexPath.row)
                                idArrayList.remove(at: indexPath.row)
                                tableView.reloadData()

                                do {
                                    try context.save()
                                } catch {
                                    print("Delete Save Error")
                                }
                                break
                            }
                        }
                    }
                } else {
                    print("result.count <= 0")
                }
            } catch {
                print("Delete Fetch Error")
            }

        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sendedId = idArrayList[indexPath.row].uuidString
        performSegue(withIdentifier: "toDetailsViewController", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsViewController" {
            let destinationVc = segue.destination as! TaskDetailViewController
            destinationVc.selectedId = sendedId
        }
    }

    func getFromCoreData() {
        
        taskListArray.removeAll()
        idArrayList.removeAll()

        let AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = AppDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskEntity")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            
            for result in results as! [NSManagedObject] {
                
                let iconName = result.value(forKey: "taskIconName") as! String
                let title = result.value(forKey: "taskTitle") as! String
                let description = result.value(forKey: "taskDescription") as! String
                let date = result.value(forKey: "taskDate") as! String
                let time = result.value(forKey: "taskTime") as! String
                let isCompleted = result.value(forKey: "taskIsCompleted") as! Bool
                let location = result.value(forKey: "taskLocation") as! String
                let priority = result.value(forKey: "taskPriority") as! String
                let notes = result.value(forKey: "taskNotes") as! String
                
                let uuid = result.value(forKey: "taskUUID") as! UUID
                
                let task = MockTaskList(iconName: iconName, title: title, description: description, date: date, time: time, location: location, priority: priority, notes: notes, isCompleted: isCompleted)
                
                taskListArray.append(task)
                idArrayList.append(uuid)
            }
            
            tableView.reloadData()
        } catch {
            print("Fetch Error")
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
