//
//  secondDataController.swift
//  labFour
//
//  Created by yzh on 2020/12/18.
//  Copyright © 2020 yzh. All rights reserved.
//

import UIKit

class secondDataController: UIViewController ,UINavigationControllerDelegate,UIImagePickerControllerDelegate{

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var back: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBAction func changeImg(_ sender: Any) {
        let imagePicker=UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            imagePicker.delegate=self
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
        }}
    
    var time:String!
    var current:String!
    var inter:Int!
    
    var remindForEdit:remind?
    
    var selectedImage:UIImage?
        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let selectedImage=info[UIImagePickerController.InfoKey.originalImage]
                as? UIImage
                else {return;}
            back.image=selectedImage;
            dismiss(animated: true, completion: nil)
        }
        
    func currentTime(){
        let date = Date()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy/MM/dd"
        current=timeFormatter.string(from: date)
    }
    
    func dateInterval(startTime:String,endTime:String)->Int{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        guard let date1 = dateFormatter.date(from: startTime),
            let date2 = dateFormatter.date(from: endTime) else {
               return -1
        }
        let components = NSCalendar.current.dateComponents([.day], from: date1, to: date2)
        //如果需要返回月份间隔，分钟间隔等等，只需要在dateComponents第一个参数后面加上相应的参数即可，示例如下：
        //    let components = NSCalendar.current.dateComponents([.month,.day,.hour,.minute], from: date1, to: date2)
        inter=components.day
        return components.day!
        
    }
    
    
        override func viewDidLoad() {
        super.viewDidLoad()
        
        if let remind=remindForEdit{
            //赋值
            print("remind.backimg is", remind.backimg)
            self.back.image=remind.backimg
            self.titleLabel.text=remind.title;
            self.dateLabel.text=remind.date;
            currentTime()
            dateInterval(startTime: current, endTime: dateLabel.text!)
            var timeday = String(inter)
            self.timeLabel.text=timeday
        }
        // Do any additional setup after loading the view.
    }
    

    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   
            //         Get the new view controller using segue.destination.
            //         Pass the selected object to the new view controller.
            
            if segue.identifier=="save"{
                remindForEdit=remind(title:titleLabel.text!,date:dateLabel.text!,backimg: back.image)
                print("back.backimg is", back.image)
            }
        }
    
 

    }
