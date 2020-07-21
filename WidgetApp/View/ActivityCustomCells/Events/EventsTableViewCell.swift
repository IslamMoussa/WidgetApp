//
//  EventsTableViewCell.swift
//  WidgetApp
//
//  Created by Bassuni on 7/19/20.
//  Copyright © 2020 futureface. All rights reserved.
//

import UIKit

class EventsTableViewCell: UITableViewCell {
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var dateLabel2: UILabel!
    @IBOutlet var headerImageView: UIImageView!
    @IBOutlet var headerTitleLabel: UILabel!
    @IBOutlet var headerEditButton: UIImageView!

    var eventCellViewModel: EventCellViewModel? {
        didSet {
            titleLabel.text = eventCellViewModel?.title
            imgView.image = UIImage(named: eventCellViewModel?.imageName ?? "")
            dateLabel.text = eventCellViewModel?.dateTxt
            dateLabel2.text = eventCellViewModel?.dateTxt
            headerTitleLabel.text = eventCellViewModel?.headerTitleText
            headerImageView.image = UIImage(named: eventCellViewModel?.headerImageName ?? "")
        }
    }
}
