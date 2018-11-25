//
//  ProfileViewController.swift
//  Restaurant
//
//  Created by Yafets Mac on 24/11/18.
//  Copyright © 2018 AppsFoundation. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var EditButton: UIButton!
    @IBOutlet weak var UploadButton: UIButton!
    @IBOutlet weak var Email: UILabel!
    @IBOutlet weak var Nama: UITextField!
    @IBOutlet weak var Telepon: UITextField!
    @IBOutlet weak var Gambar: UIImageView!
    var Editable: Bool = false
    var EditUser: User = User(name: "", email: "", password: "", phone: "", image: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EditUser = DataManager().LoadUser()
        // Do any additional setup after loading the view.
        self.UpdateData()
        isEnableEdit(able: false)
    }
    
    func UpdateData() {
        Email.text = EditUser.email
        Nama.text = EditUser.name
        Telepon.text = EditUser.phone
        DataManager().downloadImage(from: URL(string: "http://platform.yafetrakan.com/images/"+EditUser.image)!, view: Gambar!)
    }
    
    func isEnableEdit(able: Bool) {
        Nama.isEnabled = able
        Telepon.isEnabled = able
        UploadButton.isHidden = able
    }
    
    @IBAction func Edit(_ sender: Any) {
        if Editable {
            EditButton.setTitle("edit", for: UIControlState.normal)
            
            EditUser.name = Nama.text!
            EditUser.phone = Telepon.text!
            
            DataManager().DoProfileEdit(user: EditUser, view: self){
                responseObject, error in
                self.EditUser = DataManager().LoadUser()
                self.UpdateData()
                self.Editable = false
            }
            
            isEnableEdit(able: false)
            
        } else {
            EditButton.setTitle("save", for: UIControlState.normal)
            isEnableEdit(able: true)
            
            EditUser.name = Nama.text!
            EditUser.phone = Telepon.text!
            self.Editable = true
            
        }
    }
    
    @IBAction func Upload(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            self.present(imagePicker, animated: false, completion: nil)
        }
        else{
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: false, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            Gambar.image = image
            DataManager().DoUploadFoto(id: self.EditUser.id, imgData: Gambar.image!, view: self) {
                responseObject, error in
                
                self.Editable = false
                self.isEnableEdit(able: false)
            }
        }
        else if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            Gambar.contentMode = .scaleToFill
            Gambar.image = pickedImage
            
            DataManager().DoUploadFoto(id: EditUser.id, imgData: Gambar.image!, view: self) {
                responseObject, error in
                
                self.Editable = false
                self.isEnableEdit(able: false)
            }
        }
        else{
            print("Error...")
        }
        
        self.dismiss(animated: false, completion: nil)
        picker.dismiss(animated: true, completion: nil)
    }    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
