//
//  RegisterViewController.swift
//  Restaurant
//
//  Created by Yafets Mac on 16/11/18.
//  Copyright © 2018 AppsFoundation. All rights reserved.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController {

    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var Nama: UITextField!
    @IBOutlet weak var Telepon: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func DoLogin(_ sender: Any) {
        AppDelegate.sharedDelegate().openLogin()
    }
    @IBAction func DoRegister(_ sender: Any) {
        DataManager().DoRegister(user: User(name: Nama.text!, email: Email.text!, password: Password.text!, phone: Telepon.text!, image: ""), view: self){
            responseObject, error in
            if error == nil {
                AppDelegate.sharedDelegate().openLogin()
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
