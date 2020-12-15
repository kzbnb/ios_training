//
//  dataViewController.swift
//  tableview
//
//  Created by yzh on 2020/11/27.
//  Copyright © 2020 yzh. All rights reserved.
//

import UIKit
import CoreLocation

class dataViewController: UIViewController ,UINavigationControllerDelegate,CLLocationManagerDelegate,UIImagePickerControllerDelegate{

    var locationManager:CLLocationManager!

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
        
        locationManager = CLLocationManager()
        
                 // 设置定位的精确度
                 locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
                 // 设置定位变化的最小距离 距离过滤器
                 locationManager.distanceFilter = 50
        
                 // 设置请求定位的状态
                 if #available(iOS 8.0, *) {
                         locationManager.requestWhenInUseAuthorization()
                     } else {
                         // Fallback on earlier versions
                         print("hello")
                     }//这个是在ios8之后才有的
        
                 // 设置代理为当前对象
                 locationManager.delegate = self;
        
                 if CLLocationManager.locationServicesEnabled(){
                         // 开启定位服务
                         locationManager.startUpdatingLocation()
                     }else{
                         print("没有定位服务")
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
    
    lazy var geoCoder: CLGeocoder = {
        return CLGeocoder()
    }()
    
    // 定位失败调用的代理方法
    func locationManager(manager: CLLocationManager, didFailWithError error: Error) {
                 print(error)
             }
    
    var locationInfoAll:CLLocation!
         // 定位更新地理信息调用的代理方法
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                 if locations.count > 0
                 {
                            locationInfoAll=locations.last!
                         let locationInfo = locations.last!
                         let alert:UIAlertView = UIAlertView(title: "获取的地理坐标",
                                                                                message: "经度是：\(locationInfo.coordinate.longitude)，维度是：\(locationInfo.coordinate.latitude)",
                                 delegate: nil, cancelButtonTitle: "是的")
                         alert.show()
                    reverseGeoCode()
                     }
             }
    
    
    func reverseGeoCode() {
        let latitude = CLLocationDegrees(locationInfoAll.coordinate.latitude)
        let longitude = CLLocationDegrees(locationInfoAll.coordinate.longitude)
    let loc1 = CLLocation(latitude: latitude, longitude: longitude)
    geoCoder.reverseGeocodeLocation(loc1) { (pls: [CLPlacemark]?, error: Error?)  in
    if error == nil {
    print("反地理编码成功")
    guard let plsResult = pls else {return}
    let firstPL = plsResult.first
        let alert:UIAlertView = UIAlertView(title: firstPL?.name,
                                            message:firstPL?.name,
            delegate: nil, cancelButtonTitle: "是的")
        alert.show()
    }else {
    print("错误")
    }
    }
    }
    
 

}
