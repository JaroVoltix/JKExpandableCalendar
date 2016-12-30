//
//  MainCell.swift
//  JKExpandableCalendar
//
//  Created by Jarosław Krajewski on 30/12/2016.
//  Copyright © 2016 jerronimo. All rights reserved.
//

import UIKit

protocol MainCellDelegate {
    func expandCell(_ cell:MainCell)
}

class MainCell: UITableViewCell {
    @IBOutlet var test: UILabel!
    var delegate:MainCellDelegate?
    @IBAction func buttonTouched(_ sender: Any) {
        delegate?.expandCell(self)
    }
}
