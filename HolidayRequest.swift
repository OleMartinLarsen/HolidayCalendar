//
//  HolidayRequest.swift
//  HolidayCalendar
//
//  Created by Ole Martin Larsen on 20/10/2019.
//  Copyright © 2019 Ole Martin Larsen. All rights reserved.
//

import Foundation

enum HolidayError:Error {
    case noDataAvailable
    case canNotProcessData
}

struct HolidayRequset {
    let resourceURL: URL
    let API_KEY = "32ea766984286f18970a19a6527f1735d950a8fd"
    
    init(countryCode:String) {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        let currentYear = format.string(from: date)
        
        let resourceString = "https://calendarific.com/api/v2/holidays?api_key=\(API_KEY)&country=\(countryCode)&year=\(currentYear)"
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
        
        self.resourceURL = resourceURL
    }
    
    func getHolidays (completion: @escaping(Result<[HolidayDetail], HolidayError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let holidaysResponse = try decoder.decode(HolidayRepsonse.self, from: jsonData)
                let holidayDetails = holidaysResponse.response.holidays
                completion(.success(holidayDetails))
            }catch {
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
    
}
