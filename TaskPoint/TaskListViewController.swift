//
//  TaskListViewController.swift
//  TaskPoint
//
//  Created by Ahmet CILINGIR on 30.05.26.
//

import UIKit

class TaskListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

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

    }

    @objc func addNavigationButton() {
        performSegue(withIdentifier: "toAddTaskViewController", sender: nil)
    }

    @objc func exitNavigationButton() {
        performSegue(withIdentifier: "toViewController", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockTaskArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)  as! CustomTaskTableViewCell
        let task = mockTaskArray[indexPath.row]
        cell.iconImageView.image = UIImage(systemName: task.iconName)
        cell.titleLabel.text = task.title
        cell.descriptionLabel.text = task.description
        cell.dateLabel.text = task.date
        cell.timeLabel.text = task.time
        cell.isCompletedLabel.text = task.priority
        
        return cell
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
