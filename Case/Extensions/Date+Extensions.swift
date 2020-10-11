//
//  Date+Extensions.swift
//  Case
//
//  Created by Burak Furkan Asilturk on 11.10.2020.
//

import Foundation

extension Date {

    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 1, to: sunday)
    }

    var endOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 7, to: sunday)
    }
    func asString(from date: String) -> String {

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")

        return (formatter.date(from: date)?.stringDate)!
    }

    var asStringWithFullMonthName: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "tr_TR")
        formatter.dateFormat = "d MMMM YYYY"
        return formatter.string(from: self)
    }

    func toString(withFormat format: String) -> String {

        return formatType(form: format).string(from: self)
    }

    var stringDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, h:mm a"
        //formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: self)
    }

    var ddMMyyyyStringDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        //formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: self)
    }

    var ddMMyyyyHHmmStringDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        //formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: self)
    }

    var ihbarTomorrowStringDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        //formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: self.tomorrow)
    }


    func getStringDate(withFormat format: String) -> String {

        let formatter = DateFormatter()
        formatter.dateFormat = format
        //formatter.locale = Locale(identifier: UserDefaults.standard.acceptLanguage ?? "tr-TR")
        formatter.locale = Locale(identifier: "tr_TR")
        return formatter.string(from: self)
    }
    //let usLocale = Locale(identifier: "en_US")
    //let gbLocale = Locale(identifier: "en_GB")
    //let template = "yMMMMd"
    //
    //let usDateFormat = DateFormatter.dateFormat(fromTemplate: template, options: 0, locale: usLocale)!
    ////Date format for English (United States): "MMMM d, y"
    //let gbDateFormat = DateFormatter.dateFormat(fromTemplate: template, options: 0, locale: gbLocale)!
    ////Date format for English (United Kingdom): "d MMMM y"

    private func formatType(form: String) -> DateFormatter {

        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        if let currentLanguage = UserDefaults.standard.object(forKey: "LCLCurrentLanguageKey") as? String {
            dateFormatter.locale = Locale(identifier: currentLanguage)
        }
        dateFormatter.dateFormat = form
        return dateFormatter
    }

    var localDateFormatter2: DateFormatter {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")

        return dateFormatter
    }

    var dateFormatter: DateFormatter {
        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = .none
        timeFormatter.timeStyle = .short

        return timeFormatter
    }

    var localDateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")

        return dateFormatter
    }


    var decimalFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 1
        return numberFormatter
    }

    static func ISOStringFromDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"

        return dateFormatter.string(from: date).appending("Z")

        //po Date.ISOStringFromDate(date: Date())
        //print "2018-05-30T13:06:21.218Z"
    }

    static func dateFromISOString(string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        return dateFormatter.date(from: string)
    }
    var toHour: String {
        return formatType(form: "HH:mm").string(from: self)
    }

    var toDay: String {
        return formatType(form: "EEE").string(from: self)
    }

    var iso8601: String {
        return Formatter.iso8601.string(from: self)
        //let stringFromDate = Date().iso8601    //"2017-03-22T13:22:13.933Z"
    }
    var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
        //Date().yesterday   //"Oct 28, 2017 at 12:00 PM"
    }
    var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
        //Date().tomorrow    //"Oct 30, 2017 at 12:00 PM"
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
        //Date().yesterday.month   //10
    }

    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }

    var isLastDayOfMonth: Bool {
        return tomorrow.month != month
        //Date().isLastDayOfMonth  //false
    }

    var isToday: Bool {
        return Date().yesterday < self
        //Date().isLastDayOfMonth  //false
    }

    var isYesterday: Bool {
        var dayComponent    = DateComponents()
        dayComponent.day    = -1
        let theCalendar     = Calendar.current
        let beforeYesterday = theCalendar.date(byAdding: dayComponent, to: Date().yesterday)!
        return beforeYesterday < self && self < Date().yesterday
        //Date().isLastDayOfMonth  //false
    }

    //Date()             //"Oct 29, 2017 at 12:54 PM"

}

typealias UnixTime = Double

extension UnixTime {

    private func formatType(form: String) -> DateFormatter {

        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        if let currentLanguage = UserDefaults.standard.object(forKey: "LCLCurrentLanguageKey") as? String {
            dateFormatter.locale = Locale(identifier: currentLanguage)
        }
        dateFormatter.dateFormat = form
        return dateFormatter
    }
    var dateFull: Date {
        return Date(timeIntervalSince1970: Double(self))
    }
    var toHour: String {
        return formatType(form: "HH:mm").string(from: dateFull)
    }

    ///returns 5 Ara 2018
    var toDayForm1: String {
        return formatType(form: "d MMM YY").string(from: dateFull)
    }

    ///returns 15 Ara, Cmt
    var toDayForm2: String {
        return formatType(form: "d MMM, EE").string(from: dateFull)
    }


}

extension Formatter {
    static let iso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)

        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return formatter
    }()
}

extension Date {

    var weekdayName: String {
        let formatter = DateFormatter(); formatter.dateFormat = "E"; formatter.locale = Locale(identifier: "tr"); formatter.timeZone = TimeZone.current
        return formatter.string(from: self as Date)
    }

    var weekdayNameFull: String {
        let formatter = DateFormatter(); formatter.dateFormat = "EEEE"; formatter.locale = Locale(identifier: "tr"); formatter.timeZone = TimeZone.current
        return formatter.string(from: self as Date)
    }

    var onlyDay: String {
        let formatter = DateFormatter(); formatter.dateFormat = "dd"; formatter.locale = Locale(identifier: "tr"); formatter.timeZone = TimeZone.current
        return formatter.string(from: self as Date)
    }

    var monthName: String {
        let formatter = DateFormatter(); formatter.dateFormat = "MMMM"; formatter.locale = Locale(identifier: "tr"); formatter.timeZone = TimeZone.current
        return formatter.string(from: self as Date)
    }

    var monthNameShort: String {
        let formatter = DateFormatter(); formatter.dateFormat = "MMM"; formatter.locale = Locale(identifier: "tr"); formatter.timeZone = TimeZone.current
        return formatter.string(from: self as Date)
    }

    var onlyYear: String {
        let formatter = DateFormatter(); formatter.dateFormat = "YYYY"; formatter.locale = Locale(identifier: "tr"); formatter.timeZone = TimeZone.current
        return formatter.string(from: self as Date)
    }

    var period: String {
        let formatter = DateFormatter(); formatter.dateFormat = "a"; formatter.locale = Locale(identifier: "tr"); formatter.timeZone = TimeZone.current
        return formatter.string(from: self as Date)
    }

    var timeOnly: String {
        let formatter = DateFormatter(); formatter.dateFormat = "HH:mm"; formatter.locale = Locale(identifier: "tr"); formatter.timeZone = TimeZone.current
        return formatter.string(from: self as Date)
    }

    var hourOnly: String {
        let formatter = DateFormatter(); formatter.dateFormat = "HH"; formatter.locale = Locale(identifier: "tr"); formatter.timeZone = TimeZone.current
        return formatter.string(from: self as Date)
    }

    var shortDate: String {
        let formatter = DateFormatter(); formatter.dateFormat = "dd.MM.yyyy"; formatter.locale = Locale(identifier: "tr"); formatter.timeZone = TimeZone.current
        return formatter.string(from: self as Date)
    }

    var timeWithPeriod: String {
        let formatter = DateFormatter(); formatter.dateFormat = "HH : mm a"; formatter.locale = Locale(identifier: "tr"); formatter.timeZone = TimeZone.current
        return formatter.string(from: self as Date)
    }

    var datewithMonth: String {
        let formatter = DateFormatter(); formatter.dateStyle = .medium ; formatter.locale = Locale(identifier: "tr"); formatter.timeZone = TimeZone.current
        return formatter.string(from: self as Date)
    }


    /// Date degerinin utc eklenerek locale cevrilmis halidir.
    /// - Returns: date ve dateString olarak deger doner.
    func currentTimeZone() -> (dateString: String, date: Date) {// (date: Date, dateString: String) {
        let dtf = DateFormatter()
        dtf.timeZone = TimeZone.current
        dtf.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let localDateString = dtf.string(from: self)

        let timezoneOffset =  TimeZone.current.secondsFromGMT()
        let epochDate = self.timeIntervalSince1970
        let timezoneEpochOffset = (epochDate + Double(timezoneOffset))
        let localDate = Date(timeIntervalSince1970: timezoneEpochOffset)

        return (localDateString, localDate)
    }

}
