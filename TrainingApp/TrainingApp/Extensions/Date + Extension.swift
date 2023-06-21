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
}
