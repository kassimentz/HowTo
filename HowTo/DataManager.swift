//
//  DataManager.swift
//  HowTo
//
//  Created by Alice Wiener on 01/12/16.
//  Copyright © 2016 HowTo. All rights reserved.
//

import UIKit
import CloudKit

class DataManager: NSObject {
    
    class func createNew(tutorial:Tutorial, completionHandler: @escaping (_ success:Bool) -> Void) {
        
        var allRecords = [CKRecord]()
        var stepReferences = [CKReference]()
        
        for step in tutorial.steps! {
            let stepRecord = step.createRecord()
            allRecords.append(stepRecord)
            stepReferences.append(CKReference(record: stepRecord, action: .none))
        }
        
        let tutorialRecord = tutorial.createRecord()
        tutorialRecord["steps"] = stepReferences as CKRecordValue?
        
        allRecords.append(tutorialRecord)
        
        let uploadOperation = CKModifyRecordsOperation(recordsToSave: allRecords, recordIDsToDelete: nil)
        uploadOperation.isAtomic = false
        uploadOperation.database = CKContainer.default().publicCloudDatabase
        
        uploadOperation.modifyRecordsCompletionBlock = { (savedRecords, deletedRecords, operationError) -> Void in
            DispatchQueue.main.async(){
                guard operationError==nil else {
                    print(operationError ?? "")
                    completionHandler(false)
                    return
                }
                
                completionHandler(true)
            }
        }
        
        OperationQueue().addOperation(uploadOperation)
    }
    
    class func fetchTutorials(completionHandler: @escaping (_ success:Bool, _ tutorials:[Tutorial]) -> Void) {
        
        let predicate = NSPredicate(value: true)
        let sort = NSSortDescriptor(key: "creationDate", ascending: false)
        let query = CKQuery(recordType: "Tutorials", predicate: predicate)
        query.sortDescriptors = [sort]
        
        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) { results, error in
            DispatchQueue.main.async(){
                 
                if error != nil {
                    print(error ?? "")
                }

                var tutorials = [Tutorial]()
                for result in results! {
                    tutorials.append(Tutorial(record: result))
                }
                
                completionHandler(error == nil, tutorials)
            }
        }
    }
    
    class func fetchUserForTutorial(tutorial:Tutorial, completionHandler: @escaping (_ success:Bool, _ user:User?) -> Void) {
        
        if let recordId = tutorial.userReference?.recordID {
            CKContainer.default().publicCloudDatabase.fetch(withRecordID: recordId, completionHandler: { (record, error) in
                if record != nil {
                    completionHandler(error == nil, User(record:record!))
                } else {
                    completionHandler(false, nil)
                }
            })
        } else {
            completionHandler(false, nil)
        }
    }
    
    class func fetchStepsForTutorial(tutorial:Tutorial, completionHandler: @escaping (_ success:Bool, _ steps:[Steps]) -> Void) {
        
        var predicate = NSPredicate()
        if let recordID = tutorial.recordID {
            let tutorialReference:CKReference = CKReference(recordID: recordID, action: .none)
            predicate = NSPredicate(format: "tutorial == %@", argumentArray:[tutorialReference])
        }
        let sort = NSSortDescriptor(key: "order", ascending: true)
        let query = CKQuery(recordType: "Steps", predicate: predicate)
        query.sortDescriptors = [sort]
        
        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) { results, error in
            DispatchQueue.main.async(){
                
                if error != nil {
                    print(error ?? "")
                }
                
                var steps = [Steps]()
                for result in results! {
                    steps.append(Steps(record: result))
                }
                
                completionHandler(error == nil, steps)
            }
        }
    }
    
    //MARK: Helper
    
    class func asset(image:UIImage) -> CKAsset? {
        
        let data = UIImagePNGRepresentation(image);
        let url = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(NSUUID().uuidString+".dat")
        do {
            try data!.write(to: url!)
        } catch let error as NSError {
            print(error)
            return nil
        }
        
        return CKAsset(fileURL: url!)
    }
    
    
}
