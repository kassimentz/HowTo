//
//  Step.swift
//  HowTo
//
//  Created by Alice Wiener on 26/11/16.
//  Copyright © 2016 HowTo. All rights reserved.
//

import UIKit
import CloudKit
import AVFoundation

class Step: NSObject {
    
    var recordID:CKRecordID?
    var text:String?
    var videoURL:URL?
    var image:UIImage?
    var order:Int = 0
    
    override init() {}
    
    init(record:CKRecord) {
        super.init()
        self.recordID = record.recordID
        self.text = record["text"]! as? String
        self.order = record["order"] as! Int
        
        if let video = record["video"] {
            let asset:CKAsset = video as! CKAsset

            self.videoURL = asset.fileURL
            self.videoURL = self.videoURL?.appendingPathExtension("mov")

            do {
                try FileManager.default.linkItem(at:asset.fileURL, to:self.videoURL!)
            } catch let error {
                print(error)
            }
            
            let urlAsset = AVURLAsset(url: self.videoURL!, options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: urlAsset)
            do {
                let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(0, 1), actualTime: nil)
                self.image = UIImage(cgImage: cgImage)
            } catch let error {
                print(error)
            }
        }
    }
    
    func createRecord() -> CKRecord {
        let record = CKRecord(recordType: "Steps")
        record["text"] = self.text as CKRecordValue?
        record["order"] = self.order as CKRecordValue?
        //TODO: send video
        return record
    }

}
