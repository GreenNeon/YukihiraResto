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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func alertwoy(msg: String){
        var alert  = UIAlertController(title: "ALERT", message: msg, preferredStyle: UIAlertControllerStyle.alert)
        let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    @IBAction func DoRegister(_ sender: Any) {
        let parameters: Parameters = [
            "name": Nama.text,
            "phone": 01991,
            "email": Email.text,
            "password": Password.text,
            "checkpassword": Password.text
            ]
        Alamofire.request("http://platform.yafetrakan.com/api/users", method: .post, parameters: parameters).responseJSON { response in
            debugPrint(response)
            
            if let json = response.result.value {
                if json != nil {
                    self.alertwoy(msg: "Berhasil Login!!");
                }
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
