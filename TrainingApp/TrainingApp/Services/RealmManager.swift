//
//  RealmManager.swift
//  TrainingApp
//
//  Created by Grigore on 18.06.2023.
//

import Foundation
import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    
    let realm = try! Realm()
    
    private init() {}
    
    func saveWorkoutModel(_ model: WorkoutModel) {
        try! realm.write {
            realm.add(model)
//            print("Realm is located at:", realm.configuration.fileURL!)
        }
    }
    
    func getObjectsWorkoutModel() -> Results<WorkoutModel> {
        realm.objects(WorkoutModel.self)
    }
    
    func deleteWorkoutModel(_ model: WorkoutModel) {
        try! realm.write {
            realm.delete(model)
        }
    }
    
    func updateSetsRepsWorkoutModel(model: WorkoutModel, sets: Int, reps: Int) {
        try! realm.write {
            model.workoutSets = sets
            model.workoutReps = reps
        }
    }
    
    func updateSetsTimerWorkoutModel(model: WorkoutModel, sets: Int, timer: Int) {
        try! realm.write {
            model.workoutSets = sets
            model.workoutTimer = timer
        }
    }
    
    func setTrueStatusWorkoutModelForFinish(model: WorkoutModel) {
        try! realm.write {
            model.workoutStatus = true
        }
    }
    
    
}
