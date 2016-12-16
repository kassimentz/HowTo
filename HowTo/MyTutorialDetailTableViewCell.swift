//
//  MyTutorialDetailTableViewCell.swift
//  HowTo
//
//  Created by Manuela Tarouco on 14/12/16.
//  Copyright © 2016 HowTo. All rights reserved.
//

import UIKit

protocol MyTutorialDetailTableViewCellDelegate:class {
    func didEdit(title:String)
    func didEdit(description:String)
}

class MyTutorialDetailTableViewCell: UITableViewCell, UITextViewDelegate {

    @IBOutlet weak var pickedImage: UIImageView!
    @IBOutlet weak var titleText: UITextView!
    @IBOutlet weak var descricaoText: UITextView!
    
    weak var delegate: MyTutorialDetailTableViewCellDelegate!
    
    override func awakeFromNib() {
        titleText.delegate = self
        descricaoText.delegate = self
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == titleText {
            delegate.didEdit(title: textView.text)
        } else {
            delegate.didEdit(description: textView.text)
        }
    }
}
