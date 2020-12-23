//
//  thirdViewController.swift
//  labFour
//
//  Created by yzh on 2020/12/18.
//  Copyright © 2020 yzh. All rights reserved.
//

import UIKit

class thirdViewController: UIViewController {

    @IBOutlet weak var dpicker: UIDatePicker!
    
    @IBOutlet weak var nameText: UITextField!
   
    @IBOutlet weak var btnshow: UIButton!
    
    @IBAction func cancle(_ sender: Any) {
        self.dismiss(animated: true, completion:nil)
    }
    var remindForEdit:remind?

    // 使用日期格式器格式化日期、时间
    var datestr:String!
    
    @IBAction func showClicked(_ sender: UIButton) {

        
        let date = dpicker.date
        
        // 创建一个日期格式器
        let dformatter = DateFormatter()
        // 为日期格式器设置格式字符串
        dformatter.dateFormat = "yyyy/MM/dd"
        // 使用日期格式器格式化日期、时间
        datestr = dformatter.string(from: date)
        
        func currentTime() -> String {
            let date = Date()
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "yyyy/MM/dd"
            return timeFormatter.string(from: date)
        }
        
        func dateInterval(startTime:String,endTime:String) -> Int{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy/MM/dd"
            guard let date1 = dateFormatter.date(from: startTime),
                let date2 = dateFormatter.date(from: endTime) else {
                    return -1
            }
            let components = NSCalendar.current.dateComponents([.day], from: date1, to: date2)
            //如果需要返回月份间隔，分钟间隔等等，只需要在dateComponents第一个参数后面加上相应的参数即可，示例如下：
            //    let components = NSCalendar.current.dateComponents([.month,.day,.hour,.minute], from: date1, to: date2)
            return components.day!
        }
        
        var days = dateInterval(startTime: currentTime(), endTime: datestr)
        
        var strdays = String(days) ?? "null"
        
        let message =  "距离现在：\(days)天"
        
        // 创建一个UIAlertController对象（消息框），并通过该消息框显示用户选择的日期、时间
        let alertController = UIAlertController(title: "选择成功",
                                                message: message,
                                                preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //         Get the new view controller using segue.destination.
        //         Pass the selected object to the new view controller.

        if segue.identifier=="save"{
            remindForEdit=remind(title:nameText.text!,date:datestr,backimg: nil)
        }
    }
}
