//
//  DatePickerVM.swift
//  rm
//
//  Created by Muhammet Nurchayev on 30.01.2023.
//

import Foundation

final class DatePickerVM {
    
    var months: [String] = []
    var days: [String] = []
    var dates: [String] = []
    var dayNames: [String] = []
    var selectedDate: String?
    var selectedIndex: Int = 0
    
    var carNo: String
    var carType: String
    var package: ServicePackage
    var services: [Service]
    
//    MARK: -Binder
    var didStartLoading: Binder<Bool> = Binder(false)
    var didFinish: Binder<Bool> = Binder(false)
    var didFinishWithError: Binder<NetworkError?> = Binder(nil)
    
    init(package: ServicePackage, carNo: String, carType: String) {
        self.carNo = carNo
        self.carType = carType
        self.package = package
        self.services = []
        initDates()
    }
    
    init(services: [Service], carNo: String, carType: String) {
        self.carNo = carNo
        self.carType = carType
        self.services = services
        self.package = ServicePackage(sp_id: 0, title: nil, title_ru: nil, price: nil, price_big: nil)
        initDates()
    }
    
    func createOrder(date: String) {
        let stringArray = services.map { String($0.service_id ?? 0) }
        let joinedStr = stringArray.joined(separator: ",")
        self.didStartLoading.value = true
        APIDataProvider.shared.createOrder(services: joinedStr, package: package.sp_id ?? 0, car_model: AuthHelper.shared.car ?? -1, car_no: carNo, car_type: carType, is_booked: true, book_time: date, washer_id: 0, washer_count: 0) { result in
            switch result {
            case .success(let success):
                self.didStartLoading.value = false
                self.didFinish.value = true
                print(success)
            case .failure(let error):
                self.didStartLoading.value = false
                self.didFinishWithError.value = error
                print("error: \(error)")
            }
        }
    }
    
    private func initDates() {
        let now = Calendar.current.dateComponents(in: .current, from: Date())
        let today = DateComponents(year: now.year, month: now.month, day: now.day)
        let dateToday = Calendar.current.date(from: today)!
        let todayMonth = dateToday.toString(dateFormat: "MMM")
        let todayDay = dateToday.toString(dateFormat: "dd")
        let todayDate = dateToday.toString(dateFormat: "yyyy-MM-dd")
        dayNames.append(dateToday.toString(dateFormat: "EEEE"))
        dates.append(todayDate)
        months.append(todayMonth)
        days.append(todayDay)
        
        let tomorrow = DateComponents(year: now.year, month: now.month, day: now.day! + 1)
        let dateTomorrow = Calendar.current.date(from: tomorrow)!
        let tomorrowDay = dateTomorrow.toString(dateFormat: "dd")
        let tomorrowMonth = dateTomorrow.toString(dateFormat: "MMM")
        let tomorrowDate = dateTomorrow.toString(dateFormat: "yyyy-MM-dd")
        dayNames.append(dateTomorrow.toString(dateFormat: "EEEE"))
        dates.append(tomorrowDate)
        months.append(tomorrowMonth)
        days.append(tomorrowDay)
        
        let afterTomorrow = DateComponents(year: now.year, month: now.month, day: now.day! + 2)
        let dateAfterTomorrow = Calendar.current.date(from: afterTomorrow)!
        let afterTomorrowDay = dateAfterTomorrow.toString(dateFormat: "dd")
        let afterTomorrowMonth = dateAfterTomorrow.toString(dateFormat: "MMM")
        let afterTomorrowDate = dateAfterTomorrow.toString(dateFormat: "yyyy-MM-dd")
        dayNames.append(dateAfterTomorrow.toString(dateFormat: "EEEE"))
        dates.append(afterTomorrowDate)
        months.append(afterTomorrowMonth)
        days.append(afterTomorrowDay)
    }
    
}
