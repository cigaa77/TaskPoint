//
//  MapViewController.swift
//  TaskPoint
//
//  Created by Ahmet CILINGIR on 30.05.26.
//

import UIKit

class MapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationItem.title = "Select Location"
        let doneNavigationButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(doneNavigationClicked))
        navigationItem.rightBarButtonItem = doneNavigationButton
    }
    
    @objc func doneNavigationClicked() {
        navigationController?.popViewController(animated: true)
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
