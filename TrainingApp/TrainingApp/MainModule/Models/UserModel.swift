//
//  UserModel.swift
//  TrainingApp
//
//  Created by Grigore on 11.07.2023.
//

import Foundation
import RealmSwift

class UserModel: Object {
    @Persisted var userFirstName: String = "Unknown"
    @Persisted var userLastName: String = "Unknown"
    @Persisted var userHeight: Int = 0
    @Persisted var userWeight: Int = 0
    @Persisted var userTarget: Int = 0
    @Persisted var userImage: Data?
}
