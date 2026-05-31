//
//  TaskListViewController.swift
//  TaskPoint
//
//  Created by Ahmet CILINGIR on 30.05.26.
//

import UIKit

class TaskListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        /*
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: UIBarButtonItem.Style.plain, target: self, action: #selector(addNavigationButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "asd", style: UIBarButtonItem.Style.prominent, target: self, action: #selector(addNavigationButton))
        */
        
        let addNavigationButtomItem = UIBarButtonItem(title: "+", style: UIBarButtonItem.Style.plain, target: self, action: #selector(addNavigationButton))
        let addNavigationButtomItem2 = UIBarButtonItem(title: "Exit", style: UIBarButtonItem.Style.plain, target: self, action: #selector(exitNavigationButton))
        
        navigationItem.rightBarButtonItems = [addNavigationButtomItem, addNavigationButtomItem2]
        
        navigationItem.title = "My Tasks"
        
        /*
        let titleLabel = UILabel()
        titleLabel.text = "My Tasks"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = .systemPurple
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
        */
        
    }
    
    @objc func addNavigationButton () {
        performSegue(withIdentifier: "toAddTaskViewController", sender: nil)
    }
    
    @objc func exitNavigationButton () {
        performSegue(withIdentifier: "toViewController", sender: nil)
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
