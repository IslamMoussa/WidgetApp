//
//  RequestsViewModel.swift
//  WidgetApp
//
//  Created by Bassuni on 7/17/20.
//  Copyright © 2020 futureface. All rights reserved.
//

import Foundation


class RequestsViewModel {

    let apiService: APIServiceProtocol

    private var requests: [RequestModel] = [RequestModel]()

    private var cellViewModels: [RequestCellViewModel] = [RequestCellViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }

    // callback for interfaces
    var state: State = .empty {
        didSet {
            self.updateLoadingStatus?()
        }
    }

    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }

    var numberOfCells: Int {
        return cellViewModels.count
    }

    var selectedRequest: RequestCellViewModel?

    var reloadTableViewClosure: (() -> Void)?
    var showAlertClosure: (() -> Void)?
    var updateLoadingStatus: (() -> Void)?
    var goToRequestDetailsClosure: ((_ selectedRequest: RequestCellViewModel) -> Void)?

    init( apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }

    func initFetch() {
        state = .loading
        apiService.fetchRequests { [weak self] (_, requests, error) in
            guard let self = self else {
                return
            }

            guard error == nil else {
                self.state = .error
                self.alertMessage = error?.rawValue
                return
            }

            self.processFetchedRequest(requests: requests)
            self.state = .populated
        }
    }

    func goToRequestDetails() {

    }

    func getCellViewModel( at indexPath: IndexPath ) -> RequestCellViewModel {
        return cellViewModels[indexPath.row]
    }

    func getCellViewModel( at row: Int ) -> RequestCellViewModel {
        return cellViewModels[row]
    }

    func createCellViewModel( request: RequestModel ) -> RequestCellViewModel {

        return RequestCellViewModel( titleText: request.title,
                                     referenceNumText: request.referencenumber,
                                     submittedDateText: request.submittedDate,
                                     investorText: request.investor,
                                     applicantNameText: request.applicantName,
                                      emailText: request.email,
                                      mobilenumberText: request.mobilenumber,
                                      legalTypeText: request.legalType,
                                      licenseTypeText: request.licenseType,
                                      descriptionText: request.description,
                                      dateTimeText: request.dateTime,
                                      locationText: request.locationTxt,
                                      remarksText: request.remarks,
                                      expiryDateText: request.expiryDate,
                                      trackingData: request.trackingData)
    }

    private func processFetchedRequest( requests: [RequestModel] ) {
        self.requests = requests // Cache
        var vms = [RequestCellViewModel]()
        for request in requests {
            vms.append( createCellViewModel(request: request) )
        }
        self.cellViewModels = vms
    }

}

extension RequestsViewModel {
    func userPressed( at indexPath: IndexPath ) {
        let request = self.requests[indexPath.row]
        selectedRequest = createCellViewModel(request: request)
        self.goToRequestDetailsClosure?(selectedRequest!)
    }
}
