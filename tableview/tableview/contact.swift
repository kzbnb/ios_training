//
//  contact.swift
//  tableview
//
//  Created by yzh on 2020/11/20.
//  Copyright © 2020 yzh. All rights reserved.
//

import Foundation
import UIKit

class contact: NSObject, NSCoding{
    
    static let userPath=NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!+"/contactList.data"
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name,forKey: "nameKey")
        aCoder.encode(self.phone,forKey: "phoneKey")
        aCoder.encode(self.avatar,forKey: "avatarKey")
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = (aDecoder.decodeObject(forKey: "nameKey") as? String)
        phone = (aDecoder.decodeObject(forKey: "phoneKey") as? String)
        avatar = (aDecoder.decodeObject(forKey: "avatarKey") as? UIImage)
    }
    
    var name:String?;
    var phone:String?;
    var avatar:UIImage?;

    init(name:String,phone:String,avatar:UIImage?) {
        self.name=name;
        self.phone=phone;
        self.avatar=avatar
//        self.contactList=[];
    };
    

}
