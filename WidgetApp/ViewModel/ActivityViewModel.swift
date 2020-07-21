//
//  ActivityViewModel.swift
//  WidgetApp
//
//  Created by Bassuni on 7/19/20.
//  Copyright © 2020 futureface. All rights reserved.
//

import Foundation

class ActivityViewModel {

    let apiService: APIServiceProtocol

    private var activities: [Activity] = [Activity]()

    // callback for interfaces
    var state: State = .empty {
        didSet {
            self.updateLoadingStatus?()
        }
    }

    var numberOfSections: Int {
        return activities.count
    }

    var reloadTableViewClosure: (() -> Void)?
    var updateLoadingStatus: (() -> Void)?

    init( apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }

    func initFetch() {
        state = .loading
        apiService.fetchActivities { [weak self] (_, activities, error) in
            print(activities)
            guard let self = self else {
                return
            }

            guard error == nil else {
                self.state = .error
                //self.alertMessage = error?.rawValue
                return
            }

            self.processFetchedActivities(activities: activities)
            self.state = .populated
        }
    }

    func numberOfRowsOfSectionOfType(type: ActivityType ) -> Int {
        if let section = findActivityByType(value: type.rawValue, in: activities){
            return section.rowsCount
        }
        return 0
    }

    func numberOfRowsOfSection(index: Int ) -> Int {
        let activity = activities[index]
        return activity.rowsCount
    }

    func getSectionType(index: Int ) -> ActivityType? {
        if let type = ActivityType(rawValue: activities[index].type) {
            return type
        }
        return nil
    }

    func getUtilityHeaderCellViewModel(index: Int ) -> UtilityHeaderViewModel? {
        if let utility = activities[index] as? Utility {
            return UtilityHeaderViewModel(titleText: utility.title, imageName: utility.imageName,
                                          totalBillsText: utility.totalBills,
                                          totalDuesText: utility.totalDues)
        }
        return nil
    }

    func getmyRequestsHeaderCellViewModel(index: Int ) -> MyRequestHeaderCellViewModel? {
        if let request = activities[index] as? Request {
            return MyRequestHeaderCellViewModel(titleText: request.title, imageName: request.imageName,
                                                pendingRequestsText: String(request.pendingRequests))
        }
        return nil
    }

    func getActivityHeaderCellViewModel(index: Int ) -> ActivityHeaderCellViewModel {
        let activity = activities[index]

        return ActivityHeaderCellViewModel(titleText: activity.title, imageName: activity.imageName)
    }

    func getUtilityCellViewModel(indexPath: IndexPath ) -> UtilityCellViewModel? {
        if let utility = activities[indexPath.section] as? Utility {
            let data = utility.data[indexPath.row]
            return UtilityCellViewModel(titleText: data.title, dateText: data.dateTxt, priceText: data.priceTxt)
        }
        return nil
    }

    func getUtilityCellViewModel2(indexPath: IndexPath ) -> UtilityCellViewModel2? {
        if let utility = activities[indexPath.section] as? Utility {
            var vms: [UtilityCellViewModel]=[]
            for item in utility.data {
                vms.append( UtilityCellViewModel(titleText: item.title,
                                                 dateText: item.dateTxt, priceText: item.priceTxt))
            }

            return UtilityCellViewModel2(titleText: utility.title, imageName: utility.imageName,
                                         totalBillsText: utility.totalBills,
                                         totalDuesText: utility.totalDues, dataCellViewmodel: vms)
        }
        return nil
    }

    func getEventCellViewModel(indexPath: IndexPath ) -> EventCellViewModel? {
        if let event = activities[indexPath.section] as? Event {
            let data = event.data[0]
            return EventCellViewModel(headerTitleText: event.title, headerImageName: event.imageName,
                                      title: data.title, dateTxt: data.dateTxt, imageName: data.imageName)
        }
        return nil
    }

    func getTicketCellViewModel(indexPath: IndexPath ) -> TicketCellViewModel? {
        if let ticket = activities[indexPath.section] as? Ticket {
            let data = ticket.data[0]
            return TicketCellViewModel(headerTitleText: ticket.title, headerImageName: ticket.imageName,
                                       title: data.title, dateTxt: data.dateTxt, imageName: data.imageName)
        }
        return nil
    }

    func getWeatherCellViewModel(indexPath: IndexPath ) -> WeatherCellViewModel? {
        if let weather = activities[indexPath.section] as? Weather {
            var vms: [WeatherDataViewModel]=[]
            for item in weather.data {
                vms.append( WeatherDataViewModel(time: item.time,
                                                 imageName: item.imageName, degree: item.degree))
            }

            return WeatherCellViewModel(titleText: weather.title, imageName: weather.imageName,
                                        degree: weather.degree, day: weather.day,
                                        weatherImageName: weather.weatherImageName,
                                        location: weather.location, weatherText: weather.weatherText,
                                        weatherDataCellViewmodel: vms)
        }
        return nil
    }

    func moveSection(source: Int, destination: Int ) {
        let movedObject = activities[source]
        activities.remove(at: source)
        activities.insert(movedObject, at: destination)
        self.reloadTableViewClosure?()
    }

    private func processFetchedActivities( activities: [Activity] ) {
        self.activities = activities // Cache
        self.reloadTableViewClosure?()

        //var vms = [RequestCellViewModel]()
        //for request in activities {
         //   vms.append( createCellViewModel(request: request) )
        //}
        //self.cellViewModels = vms
    }

    func findActivityByType(value searchValue: String, in array: [Activity]) -> Activity? {
        for item in array where item.type == searchValue {
            return item
        }
        return nil
    }
}

