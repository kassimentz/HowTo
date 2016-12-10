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
    
    var recordIdentifier:CKRecordID?
    var title:String?
    var textDescription:String?
    var image:UIImage?
    var steps:[Steps]?
    var user: User?
    
    init(title:String, textDescription:String, image:UIImage){
        self.title = title as String
        self.textDescription = textDescription as String
        self.image = image as UIImage
    }
    
    init(record:CKRecord) {
        super.init()
        self.recordIdentifier = record.recordID
        self.title = record["title"]! as? String
        
        if let description = record["textDescription"] {
            self.textDescription = description as? String
        }
        
        let asset:CKAsset = record["image"]! as! CKAsset
        if let imageData = NSData(contentsOf: asset.fileURL) {
            self.image = UIImage(data: imageData as Data)
        }
    }
    
    func createRecord() -> CKRecord {
        let tutorialRecord = CKRecord(recordType: "Tutorials")
        tutorialRecord["title"] = self.title as CKRecordValue?
        tutorialRecord["textDescription"] = self.textDescription as CKRecordValue?
        //TODO: tutorial user reference
        
        if let img = self.image {
            tutorialRecord["image"] = DataManager.asset(image: img)
        }
        
        return tutorialRecord
    }

}
