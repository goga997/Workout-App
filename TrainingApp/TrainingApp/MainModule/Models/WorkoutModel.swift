//
//  WorkoutModel.swift
//  TrainingApp
//
//  Created by Grigore on 18.06.2023.
//

import Foundation
import RealmSwift

class WorkoutModel: Object {
    @Persisted var workoutDate: Date
    @Persisted var numberOfDay: Int = 0
    @Persisted var workoutName: String = "Unknown"
    @Persisted var workoutRepeat: Bool = true
    @Persisted var workoutSets: Int = 0
    @Persisted var workoutReps: Int = 0
    @Persisted var workoutTimer: Int = 0 // in seconds
    @Persisted var workoutImage: Data?
    @Persisted var workoutStatus: Bool = false
}
