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

    func fetchActivities( complete: @escaping ( _ success: Bool, _ activity: ActivityModel,
        _ error: APIError? ) -> Void)
}

class APIService: APIServiceProtocol {
    // Simulate a long waiting for fetching
    func fetchRequests( complete: @escaping ( _ success: Bool, _ requests: [RequestModel],
        _ error: APIError?) -> Void) {
        DispatchQueue.global().async {
            sleep(3)
            do {
                let path = Bundle.main.path(forResource: "content", ofType: "json")!
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let requests = try decoder.decode(Requests.self, from: data)
                complete(true, requests.requests, nil)
            } catch { }
        }
    }

    func fetchActivities( complete: @escaping ( _ success: Bool, _ activity: ActivityModel,
        _ error: APIError?) -> Void) {
        DispatchQueue.global().async {
            //sleep(3)
            do {
                let path = Bundle.main.path(forResource: "activities", ofType: "json")!
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let activity = try decoder.decode(ActivityModel.self, from: data)
                complete(true, activity, nil)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
}
