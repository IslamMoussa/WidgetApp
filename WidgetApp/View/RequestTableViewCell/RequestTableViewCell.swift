//
//  RequesHeaderTableViewCell.swift
//  WidgetApp
//
//  Created by Bassuni on 7/18/20.
//  Copyright © 2020 futureface. All rights reserved.
//

import Foundation
import UIKit

class RequestTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!

    var requestCellViewModel: RequestCellViewModel? {
        didSet {
            //titleLabel.text = requestCellViewModel?.titleText
            //referenceLabel.text = requestCellViewModel?.referenceNumText
            //submittedDateLabel.text = requestCellViewModel?.submittedDateText
        }
    }

}
