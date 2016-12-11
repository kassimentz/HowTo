//
//  Steps.swift
//  HowTo
//
//  Created by Alice Wiener on 26/11/16.
//  Copyright © 2016 HowTo. All rights reserved.
//

import UIKit
import CloudKit

class Steps: NSObject {
    
    var recordIdentifier:CKRecordID?
    var text:String?
    var videoURL:URL?
    var image:UIImage?
    var order:Int = 0
    
    init(text:String, videoURL:URL) {
        self.text = text as String
        self.videoURL = videoURL as URL
    }
    
    func createRecord() -> CKRecord {
        let record = CKRecord(recordType: "Steps")
        record["text"] = self.text as CKRecordValue?
        record["order"] = self.order as CKRecordValue?
        //TODO: send video
        return record
    }

}
