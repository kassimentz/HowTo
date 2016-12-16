//
//  Singleton.swift
//  HowTo
//
//  Created by Alice Wiener on 16/12/16.
//  Copyright © 2016 HowTo. All rights reserved.
//

import UIKit

class Singleton: NSObject {

    static let sharedInstance = Singleton()
    
    var isLoggingIn:Bool = false
    var currentUser:User? {
        didSet {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DidChangeCurrentUser"), object: currentUser, userInfo: nil)
        }
    }
    
    
}
