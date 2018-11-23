//
//  DataManager.swift
//  Restaurant
//
//  Created by lab_pk_30 on 23/11/18.
//  Copyright © 2018 AppsFoundation. All rights reserved.
//

import UIKit
import Alamofire

class DataManager {
    
    func alertwoy(msg: String, view: UIViewController){
        var alert  = UIAlertController(title: "ALERT", message: msg, preferredStyle: UIAlertControllerStyle.alert)
        let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(ok)
        view.present(alert, animated: true, completion: nil)
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL, view: UIImageView) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                view.image = UIImage(data: data)
            }
        }
    }
    
    func DoRegister(user: User, view: UIViewController) {
        let parameters: Parameters = [
            "name": user.name,
            "phone": user.phone,
            "email": user.email,
            "password": user.password,
            "checkpassword": user.password
        ]
        
        Alamofire.request("http://platform.yafetrakan.com/api/users", method: .post, parameters: parameters).responseJSON { response in
            debugPrint(response)
            
            if let json = response.result.value as? [String: Any]{
                if json["data"] != nil {
                    self.alertwoy(msg: "Berhasil Login!!", view: view);
                }
            }
        }
    }
    
    func DoLogin(user: User, view: UIViewController) {
        let parameters: Parameters = [
            "email": user.email,
            "password": user.password
        ]
        
        Alamofire.request("http://platform.yafetrakan.com/api/login", method: .post, parameters: parameters).responseJSON { response in
            debugPrint(response)
            
            if let json = response.result.value as? [String: Any]{
                if json["data"] != nil {
                    self.alertwoy(msg: "Berhasil Login!!", view: view);
                }
            }
        }
    }
    func DoFetchMakanan(completionHandler: @escaping ([MenuItem]?, Error?) -> ()) {
        FetchMakanan(completionHandler: completionHandler)
    }
    func FetchMakanan(completionHandler: @escaping ([MenuItem]?, Error?) -> ())
    {
        var resultItems = [MenuItem]()
        Alamofire.request("http://platform.yafetrakan.com/api/makanan").responseJSON { response in
            switch response.result {
            case .success(let value):
                if let json = value as? [String:Any]{
                    let arrMenu: NSArray = json["data"] as! NSArray
                    for menu in arrMenu {
                        let disMenu: [String: Any] = menu as! [String : Any]
                        var realMenu: MenuItem
                        realMenu = MenuItem(name: disMenu["nama"] as! String, ingredients: disMenu["deskripsi"] as! String, image: disMenu["gambar"] as! String, price: disMenu["harga"] as! String, discount: disMenu["detail"] as! String)
                        realMenu.changeId(id: disMenu["id"] as! Int)
                        resultItems.append(realMenu)
                    }
                }
                completionHandler(resultItems, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
}
