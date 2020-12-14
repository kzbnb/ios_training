//
//  dataViewController.swift
//  labFour
//
//  Created by yzh on 2020/12/11.
//  Copyright © 2020 yzh. All rights reserved.
//

import UIKit
import Foundation

class dataViewController: UIViewController {

    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var contentView: UITextView!
    var memoForEdit:memo?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let memo=memoForEdit{
            //赋值
          
                self.contentView=memo.content;
            
        }
        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         Get the new view controller using segue.destination.
//         Pass the selected object to the new view controller.


        if segue.identifier=="save"{
            let date = Date()
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "yyyy/MM/dd";
            memoForEdit=memo(title:titleText.text!,date:timeFormatter.string(from: date),content:contentView.self)
        }
    }
 

}
