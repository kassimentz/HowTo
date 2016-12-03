//
//  Tutorial.swift
//  HowTo
//
//  Created by Alice Wiener on 26/11/16.
//  Copyright © 2016 HowTo. All rights reserved.
//

import UIKit

class Tutorial: NSObject {
    
    var title:String?
    var textDescription:String?
    var image:UIImage?
    var steps:[Steps]?
    
    init(title:String, textDescription:String, image:UIImage){
        self.title = title as String
        self.textDescription = textDescription as String
        self.image = image as UIImage
    }

}
