//
//  Date+Extensions.swift
//  Case
//
//  Created by Burak Furkan Asilturk on 11.10.2020.
//

import Foundation

extension Date {

    static func date(from dateString: String?) -> Date? {
        guard let dateString = dateString else { return nil }

        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd"

        return formatter.date(from: dateString)
    }

    var onlyYear: String {
        let formatter = DateFormatter();
        formatter.dateFormat = "YYYY";
        formatter.timeZone = TimeZone.current
        return formatter.string(from: self as Date)
    }

    var shortDate: String {
        let formatter = DateFormatter();
        formatter.dateFormat = "dd.MM.yyyy";
        formatter.timeZone = TimeZone.current
        return formatter.string(from: self as Date)
    }

}
