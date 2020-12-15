//
//  memo.swift
//  labFour
//
//  Created by yzh on 2020/12/11.
//  Copyright © 2020 yzh. All rights reserved.
//

import Foundation
import UIKit

class memo: NSObject, NSCoding {
    
    static let userPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!+"/memoList.data"
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.title,forKey: "titleKey")
        aCoder.encode(self.date, forKey: "dateKey")
        aCoder.encode(self.content,forKey: "contentKey")
    }
    
    required init?(coder aDecoder: NSCoder) {
        title = (aDecoder.decodeObject(forKey: "titleKey") as? String)
        date = (aDecoder.decodeObject(forKey: "dateKey") as? String)
        content = (aDecoder.decodeObject(forKey: "contentKey") as? NSAttributedString)
    }
    
    
    
    var title: String?
    var date: String?
    var content: NSAttributedString?
//    var avatar:[UIImage]?;
    
    init(title: String, date: String, content: NSAttributedString?) {
        self.title = title
        self.date = date
        self.content = content
    }
}
