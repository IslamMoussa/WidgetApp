//
//  ActivityViewController.swift
//  WidgetApp
//
//  Created by Bassuni on 7/18/20.
//  Copyright © 2020 futureface. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController {

    @IBOutlet var tableView: UITableView!

    lazy var viewModel: ActivityViewModel = {
        return ActivityViewModel()
    }()

    var isExpanded: Bool = false

    override func viewDidLoad() {
    super.viewDidLoad()
        initUI()
        initVM()
    }

    func initUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isEditing = true
        
        tableView.register(UINib(nibName: "UtilitiesTableViewCell2", bundle: nil),
                           forCellReuseIdentifier: "UtilityCell2")
        tableView.register(UINib(nibName: "RequestHeaderTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "RequestHeaderCell")
        tableView.register(UINib(nibName: "TicketsTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "TicketsCell")
        tableView.register(UINib(nibName: "EventsTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "EventsCell")
        tableView.register(UINib(nibName: "WeatherTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "WeatherViewCell")
    }

    func initVM() {

        viewModel.reloadTableViewClosure = { [weak self] () in
                   DispatchQueue.main.async {
                       self?.tableView.reloadData()
                   }
               }

        viewModel.initFetch()
    }

}

extension ActivityViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = viewModel.getSectionType(index: indexPath.section)

        switch type {
        case .utilities:
            let cell = getUtilityCell2(indexPath: indexPath)
            if var utilityVM = viewModel.getUtilityCellViewModel2(indexPath: indexPath) {
                utilityVM.showMore = self.isExpanded
                cell.utilityCellViewModel = utilityVM
                cell.utilityCellViewModel?.reloadParentTableViewClosure = { [weak self] () in
                    if let expanded = self?.isExpanded {
                        self?.isExpanded = !expanded
                        self?.tableView.reloadData()
                    }
                }
            }
            return cell
        case .myRequests:
            let cell = getMyRequestsHeaderCell(section: indexPath.section)
            cell.requestHeaderCellViewModel = viewModel.getmyRequestsHeaderCellViewModel(index: indexPath.section)
            return cell
        case .events:
            let cell = getEventCell(indexPath: indexPath)
            cell.eventCellViewModel = viewModel.getEventCellViewModel(indexPath: indexPath)
            return cell
        case .tickets:
            let cell = getTicketCell(indexPath: indexPath)
            cell.ticketCellViewModel = viewModel.getTicketCellViewModel(indexPath: indexPath)
            return cell
        case .weather:
            let cell = getWeatherCell(indexPath: indexPath)
            cell.weatherCellViewModel = viewModel.getWeatherCellViewModel(indexPath: indexPath)
            return cell
        default:
            return UITableViewCell()
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let type = viewModel.getSectionType(index: indexPath.section)
        switch type {
        case .utilities:
            return UITableView.automaticDimension
        case .weather:
            return 300
        default:
            return 110.0
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath)
        -> UITableViewCell.EditingStyle {
        return .none
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        let imageView = cell.subviews.first(where: { $0.description.contains("Reorder") })?
            .subviews.first(where: { $0 is UIImageView }) as? UIImageView
        //imageView?.image = UIImage()
        //imageView?.contentMode = .top
        imageView?.isHidden = true

//        var ss = cell.subviews.first(where: { $0.description.contains("Reorder") })
//
//        var ff = cell as? EventsTableViewCell
//        if ff != nil{
//            ff?.headerEditButton = imageView
//        }
//        ss?.removeFromSuperview()
        cell.showsReorderControl = false
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {

       return true
    }

    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath,
                   to destinationIndexPath: IndexPath) {

        viewModel.moveSection(source: sourceIndexPath.section, destination: destinationIndexPath.section)
    }

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {

        tableView.deselectRow(at: indexPath, animated: true)
        //self.viewModel.userPressed(at: indexPath)
        return indexPath
    }

}

extension ActivityViewController {

    func getMyRequestsHeaderCell(section: Int) -> RequestHeaderTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RequestHeaderCell")
            as? RequestHeaderTableViewCell else {
            fatalError("Cell not exists in storyboard")
        }
       return cell
    }

    func getUtilityCell(indexPath: IndexPath ) -> UtilitiesTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UtilitiesCell", for: indexPath)
            as? UtilitiesTableViewCell else {
           fatalError("Cell not exists in storyboard")}
       return cell
    }

    func getUtilityCell2(indexPath: IndexPath ) -> UtilitiesTableViewCell2 {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UtilityCell2", for: indexPath)
            as? UtilitiesTableViewCell2 else {
           fatalError("Cell not exists in storyboard")}
       return cell
    }

    func getEventCell(indexPath: IndexPath ) -> EventsTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventsCell", for: indexPath)
            as? EventsTableViewCell else {
                fatalError("Cell not exists in storyboard")}
        return cell
    }

    func getTicketCell(indexPath: IndexPath ) -> TicketsTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TicketsCell", for: indexPath)
            as? TicketsTableViewCell else {
        fatalError("Cell not exists in storyboard")}
       return cell
    }


    func getWeatherCell(indexPath: IndexPath ) -> WeatherTableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherViewCell", for: indexPath)
            as? WeatherTableViewCell else {
        fatalError("Cell not exists in storyboard")}
       return cell
    }
}
