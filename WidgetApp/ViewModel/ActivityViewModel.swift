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


    var reloadTableViewClosure: (()->())?
    var updateLoadingStatus: (()->())?

    init( apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }

    func initFetch() {
        state = .loading
        apiService.fetchActivities { [weak self] (success, activities , error) in
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

    func numberOfRowsOfSection(at: Int ) -> Int {
        let activity = activities[at]
        return activity.rowsCount
    }

    func getSectionType(at: Int ) -> ActivityType {
        let type = ActivityType(rawValue: activities[at].type)!
        return type
    }

    func getUtilityHeaderCellViewModel(at: Int ) -> UtilityHeaderViewModel {
        let utility = activities[at] as! Utility
        return UtilityHeaderViewModel(titleText: utility.title, imageName: utility.imageName, totalBillsText: utility.totalBills, totalDuesText: utility.totalDues)
    }

    func getmyRequestsHeaderCellViewModel(at: Int ) -> MyRequestHeaderCellViewModel {
        let request = activities[at] as! Request

        return MyRequestHeaderCellViewModel(titleText: request.title, imageName: request.imageName, pendingRequestsText: String(request.pendingRequests))
    }

    func getActivityHeaderCellViewModel(at: Int ) -> ActivityHeaderCellViewModel {
        let activity = activities[at]

        return ActivityHeaderCellViewModel(titleText: activity.title, imageName: activity.imageName)
    }

    func getUtilityCellViewModel(indexPath: IndexPath ) -> UtilityCellViewModel {
        let utility = activities[indexPath.section] as! Utility
        let d = utility.data[indexPath.row]
        return UtilityCellViewModel(titleText: d.title, dateText: d.dateTxt, priceText: d.priceTxt)
    }

    func getUtilityCellViewModel2(indexPath: IndexPath ) -> UtilityCellViewModel2 {
        let utility = activities[indexPath.section] as! Utility

        var vms : [UtilityCellViewModel]=[]
        for item in utility.data {
            vms.append( UtilityCellViewModel(titleText: item.title, dateText: item.dateTxt, priceText: item.priceTxt))
        }

        return UtilityCellViewModel2(titleText: utility.title, imageName: utility.imageName, totalBillsText: utility.totalBills, totalDuesText: utility.totalDues, dataCellViewmodel:vms)
    }

    func getEventCellViewModel(indexPath: IndexPath ) -> EventCellViewModel {
           let event = activities[indexPath.section] as! Event
           let d = event.data[0]
        return EventCellViewModel(headerTitleText: event.title, headerImageName: event.imageName,title: d.title, dateTxt: d.dateTxt, imageName: d.imageName)
       }

    func getTicketCellViewModel(indexPath: IndexPath ) -> TicketCellViewModel {
           let ticket = activities[indexPath.section] as! Ticket
           let d = ticket.data[0]
        return TicketCellViewModel(headerTitleText: ticket.title, headerImageName: ticket.imageName,title: d.title, dateTxt: d.dateTxt, imageName: d.imageName)
       }


    func getWeatherCellViewModel(indexPath: IndexPath ) -> WeatherCellViewModel {
        let weather = activities[indexPath.section] as! Weather

        var vms : [WeatherDataViewModel]=[]
        for item in weather.data {
            vms.append( WeatherDataViewModel(time: item.time, imageName: item.imageName, degree: item.degree))
        }

        return WeatherCellViewModel(titleText: weather.title, imageName: weather.imageName, degree: weather.degree, day: weather.day, weatherImageName: weather.weatherImageName, location: weather.location, weatherText: weather.weatherText, weatherDataCellViewmodel: vms)
    }




    func moveSection(source: Int, destination: Int )  {
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

    func findActivityByType(value searchValue: String, in array: [Activity]) -> Activity?
    {
        for item in array
        {
            if item.type == searchValue {
                return item
            }
        }

        return nil
    }

}



