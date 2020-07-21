//
//  TicketsTableViewCell.swift
//  WidgetApp
//
//  Created by Bassuni on 7/19/20.
//  Copyright © 2020 futureface. All rights reserved.
//

import UIKit

class TicketsTableViewCell: UITableViewCell {

    @IBOutlet var headerImageView: UIImageView!
    @IBOutlet var headerTitleLabel: UILabel!
    @IBOutlet var headerEditButton: UIButton!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var showTicketButton: UIButton!

    var ticketCellViewModel: TicketCellViewModel? {
        didSet {
            titleLabel.text = ticketCellViewModel?.title
            imgView.image = UIImage(named: ticketCellViewModel?.imageName ?? "")
            dateLabel.text = ticketCellViewModel?.dateTxt
            headerTitleLabel.text = ticketCellViewModel?.headerTitleText
            headerImageView.image = UIImage(named: ticketCellViewModel?.headerImageName ?? "")
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        showTicketButton.radiusWithBorder(cornerRadius: 10, borderWidth: 1, hexColor: "#027C71")
    }

}
