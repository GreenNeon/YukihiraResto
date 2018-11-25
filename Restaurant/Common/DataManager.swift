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
        let alert  = UIAlertController(title: "ALERT", message: msg, preferredStyle: UIAlertControllerStyle.alert)
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
    
    func SaveUser(user: User) {
        let defaults = UserDefaults.standard
        
        var dict: [String: Any]
        if user.email == "" {
            let loaded:User = self.LoadUser()
            dict = ["id":loaded.id,"name": user.name, "phone": user.phone, "email": loaded.email, "password":loaded.password, "image_name": loaded.image] as [String : Any]
        }else {
            dict = ["id":user.id,"name": user.name, "phone": user.phone, "email": user.email, "password":user.password, "image_name": user.image] as [String : Any]
        }
        
        defaults.set(dict, forKey: "UserVault")
    }
    
    func LoadUser() -> User {
        let defaults = UserDefaults.standard
        let savedUser = defaults.object(forKey: "UserVault") as? [String:Any] ?? [String:Any]()
        var loaded = User(name: savedUser["name"] as! String, email: savedUser["email"] as! String, password: savedUser["password"] as! String, phone: savedUser["phone"] as! String, image: savedUser["image_name"] as! String)
        loaded.changeId(id: savedUser["id"] as! Int)
        
        return loaded
    }
    
    func DoRegister(user: User, view: UIViewController, completionHandler: @escaping (String?, Error?) -> ()){
        Register(user: user, view: view, completionHandler: completionHandler)
    }
    
    private func Register(user: User, view: UIViewController, completionHandler: @escaping (String?, Error?) -> ()) {
        let parameters: Parameters = [
            "name": user.name,
            "phone": user.phone,
            "email": user.email,
            "password": user.password,
            "checkpassword": user.password
        ]
        
        Alamofire.request("http://platform.yafetrakan.com/api/users", method: .post, parameters: parameters).responseJSON {
            response in switch response.result {
            case .success(let value):
                if let json = value as? [String: Any]{
                    if json["data"] != nil {
                        self.alertwoy(msg: "Berhasil Register!!", view: view)
                    } else {
                        self.alertwoy(msg: "Gagal Register!!", view: view);
                    }
                }
                completionHandler("Success",nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
    
    func DoLogin(user: User, view: UIViewController, completionHandler: @escaping (String?, Error?) -> ()){
        Login(user: user, view: view, completionHandler: completionHandler)
    }
    
    private func Login(user: User, view: UIViewController, completionHandler: @escaping (String?, Error?) -> ()) {
        let parameters: Parameters = [
            "email": user.email,
            "password": user.password
        ]
        
        Alamofire.request("http://platform.yafetrakan.com/api/login", method: .post, parameters: parameters).responseJSON {
            response in switch response.result {
                case .success(let value):
                    if let json = value as? [String: Any]{
                        if json["data"] != nil {
                            let disMenu: [String: Any] = json["data"] as! [String : Any]
                            user.name = disMenu["name"] as! String
                            user.phone = disMenu["phone"] as! String
                            user.changeId(id: disMenu["id"] as! Int)
                            if disMenu["image_name"] is NSNull {
                                user.image = ""
                            }else {
                                user.image=disMenu["image_name"] as! String
                            }
                            self.SaveUser(user: user)
                        }
                    }
                    completionHandler("Success",nil)
                case .failure(let error):
                    completionHandler(nil, error)
            }
        }
    }
    func DoFetchMakanan(completionHandler: @escaping ([MenuItem]?, Error?) -> ()) {
        FetchMakanan(completionHandler: completionHandler)
    }
    private func FetchMakanan(completionHandler: @escaping ([MenuItem]?, Error?) -> ())
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
    
    func DoUploadFoto(id: Int, imgData: UIImage, view: UIViewController, completionHandler: @escaping (String?, Error?) -> ()) {
        UploadFoto(id: id, imgData: imgData, view: view, completionHandler: completionHandler)
    }
    private func UploadFoto(id: Int, imgData: UIImage, view: UIViewController, completionHandler: @escaping (String?, Error?) -> ())
    {
        
        let url = "http://platform.yafetrakan.com/api/updateprofile/\(id)"/* your API url */
        let image = imgData
        let imgData = UIImageJPEGRepresentation(image, 0.2)!
        let headers: HTTPHeaders = [
            /* "Authorization": "your_access_token",  in case you need authorization header */
            "Content-type": "multipart/form-data"
        ]
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData, withName: "image_name",fileName: "file.jpg", mimeType: "image/jpg")
        },usingThreshold: UInt64.init(), to: url, method: .post, headers: headers)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                    if let json = response.result.value as? [String:Any]{
                        if json["data"] != nil {
                            let disMenu: [String: Any] = json["data"] as! [String : Any]
                            let user = User(name: disMenu["name"] as! String, email: "", password: "", phone: disMenu["phone"] as! String, image: disMenu["image_name"] as! String)
                            self.alertwoy(msg: "Berhasil Upload!!", view: view);
                            self.SaveUser(user: user)
                        } else {
                            self.alertwoy(msg: "Gagal UPload!!", view: view);
                        }
                    }
                    completionHandler("Success", nil)
                }
                
            case .failure(let encodingError):
                print(encodingError)
                completionHandler(nil, encodingError)
            }
        }
    }
    
    func DoProfileEdit(user: User, view: UIViewController, completionHandler: @escaping (String?, Error?) -> ()) {
        ProfileEdit(user: user, view: view, completionHandler: completionHandler)
    }
    private func ProfileEdit(user: User, view: UIViewController, completionHandler: @escaping (String?, Error?) -> ())
    {
        let parameters: Parameters = [
            "name": user.name,
            "phone": user.phone,
            "password": user.password
        ]
        
        Alamofire.request("http://platform.yafetrakan.com/api/users/\(user.id)", method: .patch, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let json = value as? [String:Any]{
                    if json["data"] != nil {
                        let disMenu: [String: Any] = json["data"] as! [String : Any]
                        var imageurl: String = ""
                        
                        if disMenu["image_name"] is NSNull {
                            imageurl = ""
                        } else {
                            imageurl = disMenu["image_name"] as! String
                        }
                        
                        let user = User(name: disMenu["name"] as! String, email: "", password: "", phone: disMenu["phone"] as! String, image: imageurl)
                        self.alertwoy(msg: "Berhasil Edit!!", view: view);
                        self.SaveUser(user: user)
                    } else {
                        self.alertwoy(msg: "Gagal Edit!!", view: view);
                    }
                }
                completionHandler("Success", nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
    
    func DoReservasi(id: Int, reservation: Reservation, completionHandler: @escaping (Reservation?, Error?) -> ()) {
        Reservasi(id: id, reservation: reservation, completionHandler: completionHandler)
    }
    
    private func Reservasi(id: Int, reservation: Reservation, completionHandler: @escaping (Reservation?, Error?) -> ()) {
        Alamofire.request("http://platform.yafetrakan.com/api/reservasi/\(id)", method: .get).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let json = value as? [String:Any]{
                    if let data = json["data"] as? [String:Any] {
                        let reservation: Reservation = Reservation(id: (data["id"] as? Int)!, userId: (data["userid"] as? Int)!, jumlahOrang: (data["jumlah_orang"] as? Int)!, tempat: (data["tempat"] as? String)!, confirmed: ("confirmed" as? Int)!)
                        completionHandler(reservation, nil)
                    } else {
                        completionHandler(Reservation(id: -1, userId: 0, jumlahOrang: 0, tempat: "0", confirmed: 0), nil)
                    }
                }
                
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
    
    func DoGetReservasi(id: Int, view: UIViewController, completionHandler: @escaping (Reservation?, Error?) -> ()) {
        GetReservasi(id: id, view: view, completionHandler: completionHandler)
    }
    
    private func GetReservasi(id: Int, view: UIViewController, completionHandler: @escaping (Reservation?, Error?) -> ()) {
       
        Alamofire.request("http://platform.yafetrakan.com/api/showunconfirmed/\(id)", method: .get).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let json = value as? [String:Any]{
                    if let data = json["data"] as? [String:Any] {
                        let reservation: Reservation = Reservation(id: (data["id"] as? Int)!, userId: (data["userid"] as? Int)!, jumlahOrang: (data["jumlah_orang"] as? Int)!, tempat: (data["tempat"] as? String)!, confirmed: ("confirmed" as? Int)!)
                        completionHandler(reservation, nil)
                    } else {
                        completionHandler(Reservation(id: -1, userId: 0, jumlahOrang: 0, tempat: "0", confirmed: 0), nil)
                    }
                }
                
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
}
