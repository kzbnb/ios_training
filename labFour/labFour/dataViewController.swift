//
//  dataViewController.swift
//  labFour
//
//  Created by yzh on 2020/12/11.
//  Copyright © 2020 yzh. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

class dataViewController: UIViewController ,UINavigationControllerDelegate,CLLocationManagerDelegate,UIImagePickerControllerDelegate{
    
    
    //文字大小
    let  textViewFont =  UIFont .systemFont(ofSize: 22)
    
    @IBAction func takePhoto(_ sender: Any) {
        let imagePicker=UIImagePickerController()
        if
            UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            imagePicker.delegate=self
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
        }
//        insertPicture( UIImage:, mode:.fitTextView)
    }
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var contentView: UITextView!
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage=info[UIImagePickerController.InfoKey.originalImage]
            as? UIImage else {return;}
        insertPicture(image: selectedImage, mode:.fitTextView)
        dismiss(animated: true, completion: nil)
    }
    var locationManager:CLLocationManager!
    var memoForEdit:memo?
    override func viewDidLoad() {
        super.viewDidLoad()
        diaoyongdizhi()
        if let memo=memoForEdit{
            //赋值
            self.titleText.text=memo.title;
            self.contentView.attributedText=memo.content;
            print(contentView.attributedText)
            
            
        }
        // Do any additional setup after loading the view.
    }
    

    var place:String!
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         Get the new view controller using segue.destination.
//         Pass the selected object to the new view controller.


        if segue.identifier=="save"{
            let date = Date()
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "yyyy/MM/dd";
            memoForEdit=memo(title:titleText.text!,date:timeFormatter.string(from: date),content:contentView!.attributedText,location:self.place)
        }
    }
    
    
    //插入文字
    func  insertString(_ text: String ) {
        //获取textView的所有文本，转成可变的文本
        let  mutableStr =  NSMutableAttributedString (attributedString: contentView.attributedText)
        //获得目前光标的位置
        let  selectedRange = contentView.selectedRange
        //插入文字
        let  attStr =  NSAttributedString (string: text)
        mutableStr.insert(attStr, at: selectedRange.location)

        //设置可变文本的字体属性
        mutableStr.addAttribute( NSAttributedString.Key.font , value: textViewFont,
                                 range:  NSMakeRange (0,mutableStr.length))
        //再次记住新的光标的位置
        let  newSelectedRange =  NSMakeRange (selectedRange.location + attStr.length, 0)

        //重新给文本赋值
        contentView.attributedText = mutableStr
        //恢复光标的位置（上面一句代码执行之后，光标会移到最后面）
        contentView.selectedRange = newSelectedRange
    }

    //插入图片
    func  insertPicture(image: UIImage , mode: ImageAttachmentMode  = . fitTextView ){
        //获取textView的所有文本，转成可变的文本
        print(contentView.attributedText)
        let  mutableStr =  NSMutableAttributedString (attributedString: contentView.attributedText)
        //创建图片附件
        let  imgAttachment =  NSTextAttachment (data:  nil , ofType:  nil )
        var  imgAttachmentString:  NSAttributedString
        imgAttachment.image = image

        //设置图片显示方式
//        if  mode == .fitTextLine {
//            //与文字一样大小
//            imgAttachment.bounds =  CGRect (x: 0, y: -4, width: textView.font!.lineHeight,
//                                            height: textView.font!.lineHeight)
//        }  else
            if  mode == .fitTextView {
            //撑满一行
            let  imageWidth = contentView.frame.width - 20
            let  imageHeight = image.size.height/image.size.width*imageWidth
            imgAttachment.bounds =  CGRect (x: 0, y: -4, width: imageWidth, height: imageHeight)
        }

        imgAttachmentString =  NSAttributedString (attachment: imgAttachment)

        //获得目前光标的位置
        let  selectedRange = contentView.selectedRange
        //插入文字
        mutableStr.insert(imgAttachmentString, at: selectedRange.location)
        //设置可变文本的字体属性
        mutableStr.addAttribute( NSAttributedString.Key.font , value: textViewFont,
                                 range:  NSMakeRange (0,mutableStr.length))
        //再次记住新的光标的位置
        let  newSelectedRange =  NSMakeRange (selectedRange.location+1, 0)

        //重新给文本赋值
        contentView.attributedText = mutableStr
        //恢复光标的位置（上面一句代码执行之后，光标会移到最后面）
        contentView.selectedRange = newSelectedRange
        //移动滚动条（确保光标在可视区域内）
        self.contentView.scrollRangeToVisible(newSelectedRange)
    }

    //插入的图片附件的尺寸样式
    enum  ImageAttachmentMode  {

        case  fitTextLine   //使尺寸适应行高
        case  fitTextView   //使尺寸适应textView
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
    
    
    var geoCoder: CLGeocoder = {
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
        print("sssssss")
        let geocoder = CLGeocoder()
        let currentLocation = CLLocation(latitude: locationInfoAll.coordinate.latitude, longitude: locationInfoAll.coordinate.longitude)
        print("6")
        geocoder.reverseGeocodeLocation(currentLocation, completionHandler: {
            (placemarks:[CLPlacemark]?, error:Error?) -> Void in
            //强制转成简体中文
            print("5")
            let array = NSArray(object: "zh-hans")
            UserDefaults.standard.set(array, forKey: "AppleLanguages")
            //显示所有信息
            if error != nil {
                print("错误：\(error!.localizedDescription))")
                
                return
            }
            print("4")
            if let p = placemarks?[0]{
                print("2")
                print(p) //输出反编码信息
                var address = ""
                
                if let country = p.country {
                    address.append("\(country)")
                }
                if let administrativeArea = p.administrativeArea {
                    address.append("\(administrativeArea)")
                }
                if let subAdministrativeArea = p.subAdministrativeArea {
                    address.append("\(subAdministrativeArea)")
                }
                if let locality = p.locality {
                    address.append("\(locality)")
                }
                if let subLocality = p.subLocality {
                    address.append("\(subLocality)")
                }
                if let thoroughfare = p.thoroughfare {
                    address.append("\(thoroughfare)")
                }
                if let subThoroughfare = p.subThoroughfare {
                    address.append("\(subThoroughfare)")
                }
                if let name = p.name {
                    address.append("\(name)")
                }
                

                print("3")
                print(address)
                self.place=address
            } else {
                print("No placemarks!")
            }
        })
    }
}
