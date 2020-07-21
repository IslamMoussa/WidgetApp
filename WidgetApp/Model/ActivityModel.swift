//
//  ActivityModel.swift
//  WidgetApp
//
//  Created by Bassuni on 7/19/20.
//  Copyright © 2020 futureface. All rights reserved.
//

import Foundation

protocol Activity: Codable {
    var type: String { get set }
    var title: String { get set }
    var imageName: String { get set }
    var rowsCount: Int { get }
}

class Utility: Activity  {
    var rowsCount: Int
    var type: String = ActivityType.Utilities.rawValue
    var title: String
    var imageName: String
    let totalBills: String
    let totalDues: String
    let data: [UtilityRow]
    init(title: String, imageName: String, totalBills: String, totalDues: String, data: [UtilityRow]) {
        self.title=title
        self.imageName=imageName
        self.totalBills=totalBills
        self.totalDues=totalDues
        self.data=data
        rowsCount = data.count
    }
}

class Request: Activity {
    var rowsCount: Int
    var type: String = ActivityType.MyRequests.rawValue
    var title: String
    var imageName: String
    let pendingRequests: Int
    init(title: String, imageName: String, pendingRequests: Int) {
        self.title=title
        self.imageName=imageName
        self.pendingRequests=pendingRequests
        rowsCount = 0
    }
}

class Event: Activity {
    var rowsCount: Int
    var type: String = ActivityType.Events.rawValue
    var title: String
    var imageName: String
    let data:[EventRow]
    init(title: String, imageName: String, data:[EventRow]) {
        self.title=title
        self.imageName=imageName
        self.data=data
        rowsCount = data.count
    }
}

class Ticket: Activity {
    var rowsCount: Int
    var type: String = ActivityType.Tickets.rawValue
    var title: String
    var imageName: String
    let data:[TicketRow]
    init(title: String, imageName: String, data: [TicketRow]) {
        self.title=title
        self.imageName=imageName
        self.data=data
        rowsCount = data.count
    }
}

class Weather: Activity {
    var rowsCount: Int
    var type: String = ActivityType.Weather.rawValue
    var title: String
    var imageName: String
    let degree: String
    let day: String
    let weatherImageName: String
    let location: String
    let weatherText: String
    let data: [WeatherRow]
    init(title: String, imageName: String,degree: String,
         day: String, weatherImageName: String, location: String,
         weatherText: String,data: [WeatherRow]) {
        self.title=title
        self.imageName=imageName
        self.location=location
        self.weatherText=weatherText
        self.weatherImageName=weatherImageName
        self.day=day
        self.degree=degree
        self.data=data
        rowsCount = data.count
    }
}

struct UtilityRow: Codable {
    let title: String
    let dateTxt: String
    let priceTxt: String
}

struct EventRow: Codable {
    let title: String
    let dateTxt: String
    let imageName: String
}

struct TicketRow: Codable {
    let title: String
    let dateTxt: String
    let imageName: String
}

struct WeatherRow: Codable {
    let time: String
    let imageName: String
    let degree: String
}
