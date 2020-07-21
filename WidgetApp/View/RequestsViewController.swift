//  ViewController.swift
//  WidgetApp
//
//  Created by Bassuni on 7/16/20.
//  Copyright © 2020 futureface. All rights reserved.
//

import UIKit

class RequestsViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    lazy var viewModel: RequestsViewModel = {
        return RequestsViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initView()
        initVM()
    }

    func initView() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(UINib(nibName: "RequestDataTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "RequestDataCell")
        tableView.register(UINib(nibName: "RequesHeaderTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "RequestHeaderCell")
        tableView.register(UINib(nibName: "RequestFooterTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "RequestFooterCell")

        let backItem = UIBarButtonItem()
        backItem.title = "My Requests"
        backItem.tintColor = .black
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backItem
    }

    func initVM() {
        viewModel.updateLoadingStatus = { [weak self] () in
            guard let self = self else {
                return
            }

            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                switch self.viewModel.state {
                case .empty, .error:
                    self.activityIndicator.stopAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.tableView.alpha = 0.0
                    })
                case .loading:
                    self.activityIndicator.startAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.tableView.alpha = 0.0
                    })
                case .populated:
                    self.activityIndicator.stopAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.tableView.alpha = 1.0
                    })
                }
            }
        }

        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }

        viewModel.goToRequestDetailsClosure = { [weak self] (vModl) in
            DispatchQueue.main.async {
                self?.performSegue(withIdentifier: "GoToRequestDetails", sender: nil)
            }
        }

        viewModel.initFetch()
    }
}

extension RequestsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RequestDataCell", for: indexPath)
            as? RequestDataTableViewCell else {
            fatalError("Cell not exists in storyboard")
        }
        
        let cellVM = viewModel.getCellViewModel(at: indexPath.section ).trackingData[indexPath.row]
        //cell.requestCellViewModel = cellVM
        cell.titleLabel?.text = cellVM.title
        cell.dateLabel?.text = cellVM.date
        switch cellVM.status {
        case "1":
            cell.statusLabel?.text = "Confirmed"
            cell.statusImageView?.tintColor = UIColor(hexString: "#08AC86")
            cell.statusLabel?.textColor = UIColor(hexString: "#08AC86")
        case "0":
            cell.statusLabel?.text = "InProgress"
            cell.statusImageView?.tintColor = UIColor(hexString: "#FF895A")
            cell.statusLabel?.textColor = UIColor(hexString: "#FF895A")
        default:
            break
        }
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RequestHeaderCell")
            as? RequesHeaderTableViewCell else {
            fatalError("Cell not exists in storyboard")
        }

        let request=viewModel.getCellViewModel(at: section)
        cell.titleLabel?.text =  request.titleText

        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50.0
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RequestFooterCell")
            as? RequestFooterTableViewCell else {
            fatalError("Cell not exists in storyboard")
        }
        let request=viewModel.getCellViewModel(at: section)
        cell.referenceNumLabel?.text =  request.referenceNumText
        cell.submitedDateLabel?.text =  request.submittedDateText

        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfCells
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 80.0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCellViewModel(at: section).trackingData.count
    }

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {

        tableView.deselectRow(at: indexPath, animated: true)
        self.viewModel.userPressed(at: indexPath)
        return indexPath
    }

}

extension RequestsViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vctrl = segue.destination as? RequestDetailsViewController,
            let request = viewModel.selectedRequest {
            print(request)
            vctrl.requestDetailsViewModel = request
        }
    }
}
