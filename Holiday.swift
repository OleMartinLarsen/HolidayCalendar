//
//  Holiday.swift
//  HolidayCalendar
//
//  Created by Ole Martin Larsen on 20/10/2019.
//  Copyright © 2019 Ole Martin Larsen. All rights reserved.
//

import Foundation

struct HolidayRepsonse:Decodable {
    var response:Holidays
}

struct Holidays:Decodable {
    var holidays:[HolidayDetail]
}

struct HolidayDetail:Decodable {
    var name:String
    var date:DateInfo
}

struct DateInfo:Decodable {
    var iso:String
}
