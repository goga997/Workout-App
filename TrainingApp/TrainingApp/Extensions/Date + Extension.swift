//
//  Date + Extension.swift
//  TrainingApp
//
//  Created by Grigore on 18.06.2023.
//

import Foundation

extension Date {
    func getWeekDayNumber() -> Int {
        let calendar = Calendar.current
        let weekDay = calendar.component(.weekday, from: self)
        return weekDay
    }
    
    
    func localDate() -> Date {
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: self))
        let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: self) ?? Date()
        return localDate
    }
    
    
    func getWeekArray() -> [[String]] {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_GB")
        formatter.dateFormat = "EEEEEE"
        let calendar = Calendar.current
        
        var weekArray: [[String]] = [[], []]
        
        for index in -6...0 {
            let date = calendar.date(byAdding: .day, value: index, to: self) ?? Date()
            
            let day = calendar.component(.day, from: date)
            weekArray[1].append("\(day)")
            let weekDay = formatter.string(from: date)
            weekArray[0].append(weekDay)
        }
        return weekArray
    }
    
    
    func offsetDays(day: Int) -> Date {
        let offsetday = Calendar.current.date(byAdding: .day, value: -day, to: self) ?? Date()
        return offsetday
    }
    
    func offsetDate(month: Int) -> Date {
        let offsetMonth = Calendar.current.date(byAdding: .month, value: -month, to: self) ?? Date()
        return offsetMonth
    }
    
    
    func startEndDate() -> (start: Date, end: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        
        let calendar = Calendar.current
//        let day = calendar.component(.day, from: self)
//        let month = calendar.component(.month, from: self)
//        let year = calendar.component(.year, from: self)
//        let dateStart = formatter.date(from: "\(year)/\(month)/\(day)") ?? Date()
        let stringDate = formatter.string(from: self)
        let totalDate = formatter.date(from: stringDate) ?? Date()
        
        let local = totalDate.localDate()
        let dateEnd: Date = {
            let components = DateComponents(day: 1)
            return calendar.date(byAdding: components, to: local) ?? Date()
        }()
         
        return (local , dateEnd)
    }
    
    
    
    func ddMMyyyyFromDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        
        let date = formatter.string(from: self)
        return date
    }
}
