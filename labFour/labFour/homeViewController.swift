//
//  homeViewController.swift
//  labFour
//
//  Created by yzh on 2020/12/16.
//  Copyright © 2020 yzh. All rights reserved.
//

import UIKit

class homeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        print("开始摇晃")
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        print("摇晃结束")
        var a=Int(arc4random() % 3)
        switch a {
        case 0  :
            showMsgbox(_message: "鸡汤1",_title:"鸡汤title")
        case 1  :
            showMsgbox(_message: "鸡汤2",_title:"鸡汤title")
        case 2  :
            showMsgbox(_message: "鸡汤3",_title:"鸡汤title")
        default :
            showMsgbox(_message: "鸡汤4",_title:"鸡汤title")
        }
        
    }
    
    override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        print("摇晃被意外终止")
    }
    
    func showMsgbox(_message: String, _title: String ){
        
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertController.Style.alert)
        let btnOK = UIAlertAction(title: "好的", style: .default, handler: nil)
        alert.addAction(btnOK)
        self.present(alert, animated: true, completion: nil)
        
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
