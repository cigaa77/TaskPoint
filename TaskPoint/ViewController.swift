//
//  ViewController.swift
//  TaskPoint
//
//  Created by Ahmet CILINGIR on 30.05.26.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    var timer = Timer()
    var count = 3

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerSelector), userInfo: nil, repeats: true)
    }
    
    @objc func timerSelector() {
        count -= 1
        if count == 0 {
            timer.invalidate()
            if Auth.auth().currentUser != nil {
                self.performSegue(
                    withIdentifier: "toNavigationController",
                    sender: nil
                )
                print("Auth !=nil")
            } else {
                print("Auth == nil")
                performSegue(withIdentifier: "toLoginViewController", sender: nil)
            }
            
            
        }
    }


}

