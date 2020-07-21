//
//  UITableViewCellExt.swift
//  WidgetApp
//
//  Created by Bassuni on 7/19/20.
//  Copyright © 2020 futureface. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {

    func getCell(identifier: String, for indexPath: IndexPath) -> UITableViewCell {

        let cell = self.dequeueReusableCell(withIdentifier: identifier, for: indexPath)

        return cell
    }

    func getCell(identifier: String) -> UITableViewCell {

        guard let cell = self.dequeueReusableCell(withIdentifier: identifier) else {
                   fatalError("Cell not exists in storyboard")}

        return cell
    }

}
