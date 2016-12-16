//
//  ColligoImageView.swift
//  Colligo-iOS
//
//  Created by Alice Wiener on 21/09/16.
//  Copyright © 2016 Alice Wiener. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableImageView: UIImageView {
    
    override func layoutSubviews() {
        verifyCircle()
    }

    @IBInspectable var circle: Bool = false {
        didSet {
            verifyCircle()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable var imageTintColor: UIColor? {
        didSet {
            image = self.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            tintColor = imageTintColor
        }
    }
    
    func verifyCircle() {
        if circle == true {
            layer.cornerRadius = min(frame.size.height/2, frame.size.width/2);
            layer.masksToBounds = true
        } else {
            layer.cornerRadius = 0;
        }
    }
}
