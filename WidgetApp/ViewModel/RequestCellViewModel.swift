//
//  RequestCellViewModel.swift
//  WidgetApp
//
//  Created by Bassuni on 7/17/20.
//  Copyright © 2020 futureface. All rights reserved.
//

import Foundation

struct RequestCellViewModel {
    let titleText: String
    let referenceNumText: String
    let submittedDateText: String
    let investorText: String
    let applicantNameText: String
    let emailText: String
    let mobilenumberText: String
    let legalTypeText: String
    let licenseTypeText: String
    let descriptionText: String
    let dateTimeText: String
    let locationText: String
    let remarksText: String
    let expiryDateText: String
    let trackingData: [TrackingModel]
}

struct RequestDataCellViewModel {
    let titleText: String
    let dateText: String
    let statusText: String
}
