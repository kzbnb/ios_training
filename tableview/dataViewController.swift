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
        diaoyongdizhi()
     
       
        
        
        
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
    
    
    func diaoyongdizhi()
    {
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
                    print("locationInfoAll",locationInfoAll.coordinate.longitude)
                    print("locationInfoAll",locationInfoAll.coordinate.latitude)
                    reverseGeocode()
                   
                     }
             }
    

    func reverseGeocode(){
        let geocoder = CLGeocoder()
        let currentLocation = CLLocation(latitude: locationInfoAll.coordinate.latitude, longitude: locationInfoAll.coordinate.longitude)
        geocoder.reverseGeocodeLocation(currentLocation, completionHandler: {
            (placemarks:[CLPlacemark]?, error:Error?) -> Void in
            //强制转成简体中文
            let array = NSArray(object: "zh-hans")
            UserDefaults.standard.set(array, forKey: "AppleLanguages")
            //显示所有信息
            if error != nil {
                print("错误：\(error!.localizedDescription))")
               
                return
            }
            
            if let p = placemarks?[0]{
                print(p) //输出反编码信息
                var address = ""
                
                if let country = p.country {
                    address.append("国家：\(country)\n")
                }
                if let administrativeArea = p.administrativeArea {
                    address.append("省份：\(administrativeArea)\n")
                }
                if let subAdministrativeArea = p.subAdministrativeArea {
                    address.append("其他行政区域信息（自治区等）：\(subAdministrativeArea)\n")
                }
                if let locality = p.locality {
                    address.append("城市：\(locality)\n")
                }
                if let subLocality = p.subLocality {
                    address.append("区划：\(subLocality)\n")
                }
                if let thoroughfare = p.thoroughfare {
                    address.append("街道：\(thoroughfare)\n")
                }
                if let subThoroughfare = p.subThoroughfare {
                    address.append("门牌：\(subThoroughfare)\n")
                }
                if let name = p.name {
                    address.append("地名：\(name)\n")
                }
                if let isoCountryCode = p.isoCountryCode {
                    address.append("国家编码：\(isoCountryCode)\n")
                }
                if let postalCode = p.postalCode {
                    address.append("邮编：\(postalCode)\n")
                }
                if let areasOfInterest = p.areasOfInterest {
                    address.append("关联的或利益相关的地标：\(areasOfInterest)\n")
                }
                if let ocean = p.ocean {
                    address.append("海洋：\(ocean)\n")
                }
                if let inlandWater = p.inlandWater {
                    address.append("水源，湖泊：\(inlandWater)\n")
                }
                
                print(address)
            } else {
                print("No placemarks!")
            }
        })
    }
    
 

}
