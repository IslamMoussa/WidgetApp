//
//  ActivityModel.swift
//  WidgetApp
//
//  Created by Bassuni on 7/19/20.
//  Copyright © 2020 futureface. All rights reserved.
//

import Foundation

protocol Activity: Decodable {
    var type: String { get set }
    var title: String { get set }
    var imageName: String { get set }
    var rowsCount: Int { get }
}

class Utility: Activity {
    var rowsCount: Int = 0
    var type: String = ActivityType.utilities.rawValue
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

    enum CodingKeys: String, CodingKey {
        case title
        case imageName
        case totalBills
        case totalDues
        case data
    }
}

class Request: Activity {
    var rowsCount: Int = 0
    var type: String = ActivityType.myRequests.rawValue
    var title: String
    var imageName: String
    let pendingRequests: Int
    init(title: String, imageName: String, pendingRequests: Int) {
        self.title=title
        self.imageName=imageName
        self.pendingRequests=pendingRequests
    }

    enum CodingKeys: String, CodingKey {
        case title
        case imageName
        case pendingRequests
    }
}

class Event: Activity {
    var rowsCount: Int = 0
    var type: String = ActivityType.events.rawValue
    var title: String
    var imageName: String
    let data: [EventRow]
    init(title: String, imageName: String, data: [EventRow]) {
        self.title=title
        self.imageName=imageName
        self.data=data
        rowsCount = data.count
    }

    enum CodingKeys: String, CodingKey {
        case title
        case imageName
        case data
    }
}

class Ticket: Activity {
    var rowsCount: Int = 0
    var type: String = ActivityType.tickets.rawValue
    var title: String
    var imageName: String
    let data: [TicketRow]
    init(title: String, imageName: String, data: [TicketRow]) {
        self.title=title
        self.imageName=imageName
        self.data=data
        rowsCount = data.count
    }

    enum CodingKeys: String, CodingKey {
        case title
        case imageName
        case data
    }
}

class Weather: Activity {
    var rowsCount: Int = 0
    var type: String = ActivityType.weather.rawValue
    var title: String
    var imageName: String
    let degree: String
    let day: String
    let weatherImageName: String
    let location: String
    let weatherText: String
    let data: [WeatherRow]
    init(title: String, imageName: String, degree: String,
         day: String, weatherImageName: String, location: String,
         weatherText: String, data: [WeatherRow]) {
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

    enum CodingKeys: String, CodingKey {
        case title
        case imageName
        case degree
        case day
        case weatherImageName
        case location
        case weatherText
        case data
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

struct ActivityModel: Decodable {
    let utility: Utility
    let myRequests: Request
    let event: Event
    let ticket: Ticket
    let weather: Weather
    var activities: [Activity]
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        utility = try container.decode(Utility.self, forKey: .utility)
        event = try container.decode(Event.self, forKey: .event)
        myRequests = try container.decode(Request.self, forKey: .myRequests)
        ticket = try container.decode(Ticket.self, forKey: .ticket)
        weather = try container.decode(Weather.self, forKey: .weather)
        activities = [utility, myRequests, event, ticket, weather]
    }

    enum CodingKeys: String, CodingKey {
        case utility
        case event
        case ticket
        case myRequests
        case weather
    }
}
