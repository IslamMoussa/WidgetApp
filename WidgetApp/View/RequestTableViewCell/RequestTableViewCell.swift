

import Foundation
import UIKit

class RequestTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!

    var requestCellViewModel : RequestCellViewModel? {
        didSet {
            //titleLabel.text = requestCellViewModel?.titleText
            //referenceLabel.text = requestCellViewModel?.referenceNumText
            //submittedDateLabel.text = requestCellViewModel?.submittedDateText
        }
    }

}

