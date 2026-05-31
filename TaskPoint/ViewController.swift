//
//  ViewController.swift
//  TaskPoint
//
//  Created by Ahmet CILINGIR on 30.05.26.
//

import UIKit

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
            performSegue(withIdentifier: "toLoginViewController", sender: nil)
            
        }
    }


}

