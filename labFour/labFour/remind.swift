//
//  File.swift
//  labFour
//
//  Created by yzh on 2020/12/18.
//  Copyright © 2020 yzh. All rights reserved.
//

import Foundation
import UIKit


class remind:NSObject, NSCoding{
    
    static let userPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!+"/remindList.data"
    
    
    var title:String?
    var date:String?
    var backimg:UIImage?
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.title,forKey: "titleKey")
        aCoder.encode(self.date, forKey: "dateKey")
        aCoder.encode(self.backimg,forKey: "imgKey")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        title = (aDecoder.decodeObject(forKey: "titleKey") as? String)
        date = (aDecoder.decodeObject(forKey: "dateKey") as? String)
        backimg = (aDecoder.decodeObject(forKey: "imgKey") as? UIImage)
        
    }
    
    init(title: String, date: String,backimg:UIImage?) {
        self.title = title
        self.date = date
        self.backimg=backimg
    }
}
