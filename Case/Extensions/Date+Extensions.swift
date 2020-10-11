//
//  Date+Extensions.swift
//  Case
//
//  Created by Burak Furkan Asilturk on 11.10.2020.
//

import Foundation

extension Date {

    var onlyYear: String {
        let formatter = DateFormatter(); formatter.dateFormat = "YYYY"; formatter.locale = Locale(identifier: "tr"); formatter.timeZone = TimeZone.current
        return formatter.string(from: self as Date)
    }

    var shortDate: String {
        let formatter = DateFormatter(); formatter.dateFormat = "dd.MM.yyyy"; formatter.locale = Locale(identifier: "tr"); formatter.timeZone = TimeZone.current
        return formatter.string(from: self as Date)
    }


    /// Date degerinin utc eklenerek locale cevrilmis halidir.
    /// - Returns: date ve dateString olarak deger doner.
    static func date(from dateString: String?) -> Date? {
        guard let dateString = dateString else { return nil }
        
        let dtf = DateFormatter()
        dtf.timeZone = TimeZone.current
        dtf.dateFormat = "yyyy-MM-dd"

        return dtf.date(from: dateString)
    }

}
