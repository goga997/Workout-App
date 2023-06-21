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
}
