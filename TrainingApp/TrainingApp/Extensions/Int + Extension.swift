//
//  Int + Extension.swift
//  TrainingApp
//
//  Created by Grigore on 17.06.2023.
//

import Foundation

extension Int {
    func getTimeFromSeconds() -> String {
        if self % 60 == 0 {
            return "\(self / 60) min"
        }
        
        if self / 60 == 0 {
            return "\(self % 60) sec"
        }
        
       return "\(self / 60) min \(self % 60) sec"
    }
    
    func convertSecond() -> (Int, Int) {
        let min = self / 60
        let sec = self % 60
        return (min, sec)
    }
    
    func addZeroIfValueLessNine() -> String {
        Double(self) / 10.0 < 1 ? "0\(self)" : "\(self)"
    }
}
