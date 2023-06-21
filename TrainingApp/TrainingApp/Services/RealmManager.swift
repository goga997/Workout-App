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
    
    
}
