//
//  LoginViewController.swift
//  TaskPoint
//
//  Created by Ahmet CILINGIR on 30.05.26.
//

import FirebaseAuth
import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      /*
        if Auth.auth().currentUser != nil {
            self.performSegue(
                withIdentifier: "toTaskListViewController",
                sender: nil
            )
            print("Auth !=nil")
        } else {
            print("Auth == nil")
        }
       */
    }
    override func viewWillAppear(_ animated: Bool) {
        /*
        if Auth.auth().currentUser != nil {
            self.performSegue(
                withIdentifier: "toTaskListViewController",
                sender: nil
            )
            print("Auth !=nil")
        } else {
            print("Auth == nil")
        }
        */
    }

    @IBAction func signInButtonClicked(_ sender: Any) {
        if let username = usernameTextField.text {
            if let password = passwordTextField.text {
                Auth.auth().signIn(withEmail: username, password: password) { data, error in
                    if error != nil {
                        //print(error?.localizedDescription)
                        self.makeAlert(
                            alertTitle: "SignIn Error",
                            alertMessage: error?.localizedDescription
                                ?? "Unknown Error"
                        )
                    } else {
                        //print("success login")
                        self.performSegue(
                            withIdentifier: "toTaskListViewController",
                            sender: nil
                        )
                    }
                }
            }
        }
    }

    @IBAction func signUpButtonClicked(_ sender: Any) {
        if let username = usernameTextField.text {
            if let password = passwordTextField.text {
                Auth.auth().createUser(withEmail: username, password: password) { data, error in
                    if error != nil {
                        //print(error?.localizedDescription)
                        self.makeAlert(
                            alertTitle: "SignUp Error",
                            alertMessage: error?.localizedDescription
                                ?? "Unknown Error"
                        )
                    } else {
                        //print("success")
                        self.performSegue(
                            withIdentifier: "toTaskListViewController",
                            sender: nil
                        )
                    }
                }
            }
        }
    }

    func makeAlert(alertTitle: String, alertMessage: String) {
        let alert = UIAlertController(
            title: alertTitle,
            message: alertMessage,
            preferredStyle: UIAlertController.Style.alert
        )
        let button = UIAlertAction(
            title: "OK",
            style: UIAlertAction.Style.default
        )
        alert.addAction(button)
        present(alert, animated: true)
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
