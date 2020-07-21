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
    func gradientStyle() {
        priceLabel.applyGradientWith(startColor: UIColor(hexString: "#606B77"),
                                     endColor: UIColor(hexString: "#B9C3D0"))
        dateLabel.applyGradientWith(startColor: UIColor(hexString: "#606B77"),
                                    endColor: UIColor(hexString: "#B9C3D0"))
        titleLabel.applyGradientWith(startColor: UIColor(hexString: "#606B77"),
                                     endColor: UIColor(hexString: "#B9C3D0"))
    }

    func defaultStyle() {
        priceLabel.textColor = .black
        titleLabel.textColor = .systemGray
        dateLabel.textColor = .systemGray
    }
}
