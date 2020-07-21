//
//  WeatherCollectionViewCell.swift
//  WidgetApp
//
//  Created by Bassuni on 7/20/20.
//  Copyright © 2020 futureface. All rights reserved.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {

    @IBOutlet var degreeLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var weatherImgView: UIImageView!
    var weatherDataViewModel: WeatherDataViewModel? {
        didSet {
            degreeLabel.text = weatherDataViewModel?.degree
            timeLabel.text =  weatherDataViewModel?.time
            weatherImgView.image = UIImage(named: weatherDataViewModel?.imageName ?? "")

        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
