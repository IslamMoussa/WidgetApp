//
//  UtilitiesTableViewCell2.swift
//  WidgetApp
//
//  Created by Bassuni on 7/19/20.
//  Copyright © 2020 futureface. All rights reserved.
//

import UIKit

class UtilitiesTableViewCell2: UITableViewCell {

    @IBOutlet var containerView: UIView!
    @IBOutlet var moreButton: UIButton!
    @IBOutlet var payNowButton: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var sectionImageView: UIImageView!
    @IBOutlet var sectionTitleLabel: UILabel!
    @IBOutlet var sectionEditButton: UIButton!
    @IBOutlet var totalBillsLabel: UILabel!
    @IBOutlet var totalDueLabel: UILabel!
    var items: [UtilityCellViewModel]?

    var utilityCellViewModel: UtilityCellViewModel2? {
        didSet {
            sectionTitleLabel.text = utilityCellViewModel?.titleText
            sectionImageView.image = UIImage(named: utilityCellViewModel?.imageName ?? "")
            totalBillsLabel.text = utilityCellViewModel?.totalBillsText
            totalDueLabel.text = utilityCellViewModel?.totalDuesText
            let isShowMore = utilityCellViewModel?.showMore ?? false
            items = isShowMore ? utilityCellViewModel?.dataCellViewmodel: utilityCellViewModel?.prefixData(max: 4)
            moreButton.setImage(UIImage(systemName: isShowMore ? "chevron.up" : "chevron.down"), for: .normal)
            tableView.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initUI()
    }
}

extension UtilitiesTableViewCell2 {
    func initUI() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(UINib(nibName: "UtilitiesTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "UtilitiesCell")

        payNowButton.radiusWithBorder(cornerRadius: 10, borderWidth: 1, hexColor: "#027C71")
        containerView.radiusWithBorder(cornerRadius: 10, borderWidth: 0.2, color: UIColor.lightGray.cgColor)
    }

    @IBAction func expandAction(_ sender: UIButton) {
        utilityCellViewModel?.showMore = !(utilityCellViewModel?.showMore ??  false)
        utilityCellViewModel?.reloadParentTableViewClosure?()
    }

}

extension UtilitiesTableViewCell2: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = getUtilityCell(indexPath: indexPath)
        cell.utilityCellViewModel = utilityCellViewModel?.dataCellViewmodel[indexPath.row]
        return cell

    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        let intTotalrow = tableView.numberOfRows(inSection: indexPath.section)
        if let utilityCell = cell as? UtilitiesTableViewCell {
            if indexPath.row == intTotalrow - 1 {
                utilityCell.gradientStyle()
            } else {
                utilityCell.defaultStyle()
            }
        }
    }
}

extension UtilitiesTableViewCell2 {
    func getUtilityCell(indexPath: IndexPath ) -> UtilitiesTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UtilitiesCell", for: indexPath)
            as? UtilitiesTableViewCell else {
                fatalError("Cell not exists in storyboard")}
        return cell
    }
}
