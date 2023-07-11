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
    
    //MARK: - work with userData
    
    func getUsersModel() -> Results<UserModel> {
        realm.objects(UserModel.self)
    }
    
    func saveUserModel(_ model: UserModel) {
        try! realm.write {
            realm.add(model)
        }
    }
    
    func updateUserModel (model: UserModel) {
        let users = realm.objects(UserModel.self)
        try! realm.write {
            users[0].userFirstName = model.userFirstName
            users[0].userLastName = model.userLastName
            users[0].userHeight = model.userHeight
            users[0].userWeight = model.userWeight
            users[0].userTarget = model.userTarget
            users[0].userImage = model.userImage 
            
        }
    }
    
}
