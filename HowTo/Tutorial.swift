//
//  Tutorial.swift
//  HowTo
//
//  Created by Alice Wiener on 26/11/16.
//  Copyright © 2016 HowTo. All rights reserved.
//

import UIKit
import CloudKit

class Tutorial: NSObject {
    
    var record:CKRecord?
    var title:String?
    var textDescription:String?
    var image:UIImage?
    var steps:[Step]?
    var user: User?
    var userReference: CKReference?
    
    override init() {}
    
    init(title:String, textDescription:String, image:UIImage){
        self.title = title as String
        self.textDescription = textDescription as String
        self.image = image as UIImage
    }
    
    init(record:CKRecord) {
        super.init()
        self.record = record
        
        if let title = record["title"] {
            self.title = title as? String
        }

        if let user = record["user"] {
            self.userReference = user as? CKReference
        }
        
        if let description = record["textDescription"] {
            self.textDescription = description as? String
        }
        
        if let image = record["image"] {
            let asset:CKAsset = image as! CKAsset
            if let imageData = NSData(contentsOf: asset.fileURL) {
                self.image = UIImage(data: imageData as Data)
            }
        }
    }
    
    func createRecord() -> CKRecord {
        
        let tutorialRecord = record != nil ? record! : CKRecord(recordType: "Tutorials")
        
        if let title = self.title {
            tutorialRecord["title"] = title as CKRecordValue?
        }
        
        if let desc = self.textDescription {
            tutorialRecord["textDescription"] = desc as CKRecordValue?
        }
        
        if let record = Singleton.sharedInstance.currentUser?.record {
            tutorialRecord["user"] = CKReference(recordID: record.recordID, action: .none)
        }
        
        if let img = self.image {
            tutorialRecord["image"] = DataManager.asset(image: img)
        }
        
        return tutorialRecord
    }

}
