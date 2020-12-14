//
//  dataViewController.swift
//  tableview
//
//  Created by yzh on 2020/11/27.
//  Copyright © 2020 yzh. All rights reserved.
//

import UIKit

class dataViewController: UIViewController ,UINavigationControllerDelegate,UIImagePickerControllerDelegate{


    @IBAction func tapForPhoto(_ sender: Any) {
        let imagePicker=UIImagePickerController()
        if
            UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            imagePicker.delegate=self
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
        }
    }
    @IBAction func takePhoto(_ sender: Any) {
        let imagePicker=UIImagePickerController()
        if
            UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            imagePicker.delegate=self
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
        }
    }


   
    @IBOutlet weak var avatarLabel: UIImageView!
    @IBOutlet weak var nameText:UITextField!
    
    @IBOutlet weak var phoneNumText: UITextField!
    var contactForEdit:contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let contact=contactForEdit{
            self.nameText.text=contact.name
            self.phoneNumText.text=contact.phone;
            self.avatarLabel.image=contact.avatar;
        }
        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier=="save"{
            contactForEdit=contact(name:nameText.text!,phone:phoneNumText.text!,avatar: avatarLabel.image!)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage=info[UIImagePickerController.InfoKey.originalImage]
        as? UIImage
        self.avatarLabel.image=selectedImage
        dismiss(animated: true, completion: nil)
    }
 

}
