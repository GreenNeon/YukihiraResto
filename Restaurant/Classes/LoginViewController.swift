//
//  LoginViewController.swift
//  Restaurant
//
//  Created by Yafets Mac on 16/11/18.
//  Copyright © 2018 AppsFoundation. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func Register(_ sender: Any) {
        AppDelegate.sharedDelegate().openReg()
    }
    
    @IBAction func Login(_ sender: Any) {
        DataManager().DoLogin(user: User(name: "", email: Email.text!, password: Password.text!, phone: "", image: ""), view: self){
            responseObject, error in
            if error == nil {
                LeftMenuViewController.menuItems[1] = "PROFILE"
                AppDelegate.sharedDelegate().openOurMenu()
            }
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
