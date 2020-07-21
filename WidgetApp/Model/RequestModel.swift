//
//  RequestModel.swift
//  WidgetApp
//
//  Created by Bassuni on 7/17/20.
//  Copyright © 2020 futureface. All rights reserved.
//

import Foundation

struct Requests: Codable {
    let requests: [RequestModel]
}

struct RequestModel: Codable{
    let title: String
    let referencenumber: String
    let submittedDate: String
    let investor: String
    let applicantName: String
    let email: String
    let mobilenumber: String
    let legalType: String
    let licenseType: String
    let description: String
    let dateTime: String
    let locationTxt: String
    let remarks: String
    let expiryDate: String
    let trackingData: [TrackingModel]
}

struct TrackingModel: Codable {
    let title: String
    let date: String
    let status: String
}
