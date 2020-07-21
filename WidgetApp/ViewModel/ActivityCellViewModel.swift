//
//  ActivityCellViewModel.swift
//  WidgetApp
//
//  Created by Bassuni on 7/19/20.
//  Copyright © 2020 futureface. All rights reserved.
//

import Foundation

struct UtilityCellViewModel {
    let titleText: String
    let dateText: String
    let priceText: String
}

struct UtilityHeaderViewModel {
    let titleText: String
    let imageName: String
    let totalBillsText: String
    let totalDuesText: String
}

struct MyRequestHeaderCellViewModel {
    let titleText: String
    let imageName: String
    let pendingRequestsText: String
}

struct ActivityHeaderCellViewModel {
    let titleText: String
    let imageName: String
}

struct EventCellViewModel {
    let headerTitleText: String
    let headerImageName: String
    let title: String
    let dateTxt: String
    let imageName: String
}

struct TicketCellViewModel {
    let headerTitleText: String
    let headerImageName: String
    let title: String
    let dateTxt: String
    let imageName: String
}

struct UtilityCellViewModel2 {
    let titleText: String
    let imageName: String
    let totalBillsText: String
    let totalDuesText: String
    let dataCellViewmodel: [UtilityCellViewModel]
    var showMore: Bool = false
    var reloadParentTableViewClosure: (() -> Void)?

    func reloadParentTV() {
        self.reloadParentTableViewClosure?()
    }

    func prefixData(max: Int) -> [UtilityCellViewModel] {
        var items: [UtilityCellViewModel] = []
        var ind: Int = 0
        let arr = dataCellViewmodel
        for item in arr where ind < max {
            items.append(item)
            ind+=1
        }
        return items
    }
}

struct WeatherCellViewModel {
    let titleText: String
    let imageName: String
    let degree: String
    let day: String
    let weatherImageName: String
    let location: String
    let weatherText: String
    let weatherDataCellViewmodel: [WeatherDataViewModel]
}

struct WeatherDataViewModel {
    let time: String
    let imageName: String
    let degree: String
}
