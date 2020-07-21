//
//  RequestHeaderTableViewCell.swift
//  WidgetApp
//
//  Created by Bassuni on 7/19/20.
//  Copyright © 2020 futureface. All rights reserved.
//

import UIKit

class RequestHeaderTableViewCell: UITableViewCell {
    @IBOutlet var sectionImageView: UIImageView!
    @IBOutlet var pendingRequestsLabel: UILabel!
    @IBOutlet var sectionTitleLabel: UILabel!
    @IBOutlet var viewAllButton: UIButton!
    @IBOutlet var editButton: UIButton!

    var requestHeaderCellViewModel: MyRequestHeaderCellViewModel? {
        didSet {
            sectionTitleLabel.text = requestHeaderCellViewModel?.titleText
            sectionImageView.image = UIImage(named: requestHeaderCellViewModel?.imageName ?? "")
            pendingRequestsLabel.text = requestHeaderCellViewModel?.pendingRequestsText
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        viewAllButton.radiusWithBorder(cornerRadius: 10, borderWidth: 1, hexColor: "#027C71")

    }
}
