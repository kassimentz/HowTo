//
//  StepsTableViewCell.swift
//  HowTo
//
//  Created by Kassiane Mentz on 03/12/16.
//  Copyright © 2016 HowTo. All rights reserved.
//

import UIKit

protocol StepsTableViewCellDelegate:class {
    func removeStep(step:Step)
}

class StepsTableViewCell: UITableViewCell {

    @IBOutlet weak var stepsImageDetail: UIImageView!
    @IBOutlet weak var stepsTitleDetail: UILabel!
    @IBOutlet weak var stepsDescriptionDetail: UILabel!
    
    var step:Step?
    
    weak var delegate: StepsTableViewCellDelegate!

    @IBAction func didTapRemoveButton(_ sender: Any) {
        delegate.removeStep(step:step!)
    }
}
