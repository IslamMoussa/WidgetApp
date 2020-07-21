//
//  APIService.swift
//  WidgetApp
//
//  Created by Bassuni on 7/17/20.
//  Copyright © 2020 futureface. All rights reserved.
//

import Foundation

enum APIError: String, Error {
    case noNetwork = "No Network"
    case serverOverload = "Server is overloaded"
    case permissionDenied = "You don't have permission"
}

protocol APIServiceProtocol {
    func fetchRequests( complete: @escaping ( _ success: Bool, _ requests: [RequestModel],
        _ error: APIError? ) -> Void)

    func fetchActivities( complete: @escaping ( _ success: Bool, _ activities: [Activity],
        _ error: APIError? ) -> Void)
}

class APIService: APIServiceProtocol {
    // Simulate a long waiting for fetching
    func fetchRequests( complete: @escaping ( _ success: Bool, _ requests: [RequestModel],
        _ error: APIError?) -> Void) {
        DispatchQueue.global().async {
            sleep(3)
            let path = Bundle.main.path(forResource: "content", ofType: "json")!
            let data = try! Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            do {
                let requests = try decoder.decode(Requests.self, from: data)
                complete(true, requests.requests, nil)
            }
            catch { }
        }
    }

    func fetchActivities( complete: @escaping ( _ success: Bool, _ activities: [Activity],
        _ error: APIError?)-> Void) {
        DispatchQueue.global().async {
            //sleep(2)

            let activities: [Activity] = [
                Utility(title: "Utilities & Bills", imageName: "Group 7",
                        totalBills: "1,200 AED", totalDues: "950 AED",
                        data: [UtilityRow(title: "SEWA Bill",
                                          dateTxt: "Due: 28 Jul 2020", priceTxt: "400 AED"),
                UtilityRow(title: "SEWA Bill", dateTxt: "Due: 28 Jul 2020", priceTxt: "400 AED"),
                UtilityRow(title: "SEWA Bill", dateTxt: "Due: 28 Jul 2020", priceTxt: "400 AED"),
                UtilityRow(title: "SEWA Bill", dateTxt: "Due: 28 Jul 2020", priceTxt: "400 AED"),
                UtilityRow(title: "SEWA Bill", dateTxt: "Due: 28 Jul 2020", priceTxt: "400 AED"),
                UtilityRow(title: "SEWA Bill", dateTxt: "Due: 28 Jul 2020", priceTxt: "400 AED"),
                UtilityRow(title: "SEWA Bill", dateTxt: "Due: 28 Jul 2020", priceTxt: "400 AED"),
                UtilityRow(title: "SEWA Bill", dateTxt: "Due: 28 Jul 2020", priceTxt: "400 AED"),
                UtilityRow(title: "SEWA Bill", dateTxt: "Due: 28 Jul 2020", priceTxt: "400 AED"),
                UtilityRow(title: "SEWA Bill", dateTxt: "Due: 28 Jul 2020", priceTxt: "400 AED"),
                UtilityRow(title: "SEWA Bill", dateTxt: "Due: 28 Jul 2020", priceTxt: "400 AED"),
                UtilityRow(title: "SEWA Bill", dateTxt: "Due: 28 Jul 2020", priceTxt: "400 AED"),
                UtilityRow(title: "SEWA Bill", dateTxt: "Due: 28 Jul 2020", priceTxt: "400 AED"),
                UtilityRow(title: "SEWA Bill", dateTxt: "Due: 28 Jul 2020", priceTxt: "400 AED")]),
                Request(title: "My Requests", imageName: "Group 27", pendingRequests: 12),
                Event(title: "Upcoming Event", imageName: "Group 9",
                      data: [
                        EventRow(title: "March Meeting 2020: Unravelling the Present",
                                 dateTxt: "14 Sep - 18 Sep | 9:00 AM", imageName: "img1")
                ]),
                Ticket(title: "Tickets", imageName: "Group 9", data: [
                        TicketRow(title: "Rainroom", dateTxt: "14 Sep - 18 Sep | 9:00 AM",
                                  imageName: "img2")
                ]),

                Weather(title: "Weather", imageName: "Group 8", degree: "22", day: "Friday",
                        weatherImageName: "sunny", location: "Sharjah",
                        weatherText: "Mostly Clear", data: [
                    WeatherRow(time: "5 PM", imageName: "sunny", degree: "22"),
                    WeatherRow(time: "6 PM", imageName: "cloudy1", degree: "22"),
                    WeatherRow(time: "7 PM", imageName: "cloudy2", degree: "22"),
                    WeatherRow(time: "8 PM", imageName: "cloudy3", degree: "22"),
                    WeatherRow(time: "9 PM", imageName: "cloudy2", degree: "22"),
                    WeatherRow(time: "10 PM", imageName: "cloudy1", degree: "22"),
                    WeatherRow(time: "11 PM", imageName: "cloudy1", degree: "22"),
                    WeatherRow(time: "12 PM", imageName: "cloudy1", degree: "22"),
                    WeatherRow(time: "13 PM", imageName: "cloudy1", degree: "22"),
                    WeatherRow(time: "14 PM", imageName: "cloudy1", degree: "22"),
                    WeatherRow(time: "15 PM", imageName: "cloudy1", degree: "22"),
                    WeatherRow(time: "16 PM", imageName: "cloudy1", degree: "22")
                ])
            ]

            complete(true, activities, nil)
        }
    }
}
