//
//  User.swift
//  HowTo
//
//  Created by Kassiane Mentz on 03/12/16.
//  Copyright © 2016 HowTo. All rights reserved.
//

import UIKit
import CloudKit

class User: NSObject {
    
    var recordID:CKRecordID?
    var name:String?
    var image:UIImage?
    
    var username:String?
    var password:String?
    
    init(record:CKRecord) {
        super.init()
        
        self.recordID = record.recordID
        self.name = record["name"]! as? String
        
        let asset:CKAsset = record["image"]! as! CKAsset
        if let imageData = NSData(contentsOf: asset.fileURL) {
            self.image = UIImage(data: imageData as Data)
        }
    }
    
}
