//
//  UtilitiesTableViewCell.swift
//  WidgetApp
//
//  Created by Bassuni on 7/18/20.
//  Copyright © 2020 futureface. All rights reserved.
//

import UIKit

class UtilitiesTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var arrowButton: UIButton!

    var utilityCellViewModel: UtilityCellViewModel? {
        didSet {
            titleLabel.text = utilityCellViewModel?.titleText
            priceLabel.text = utilityCellViewModel?.priceText
            dateLabel.text = utilityCellViewModel?.dateText
        }
    }
    
}
