//
//  UIButtonExt.swift
//  WidgetApp
//
//  Created by Bassuni on 7/19/20.
//  Copyright © 2020 futureface. All rights reserved.
//

import Foundation
import UIKit

extension UIButton{
    func radiusWithBorder(cornerRadius: Int,borderWidth: Int,hexColor: String) {
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(hexString: hexColor).cgColor
        self.clipsToBounds = true

    }
}
