//
//  MainTableView.swift
//  TrainingApp
//
//  Created by Grigore on 14.06.2023.
//

import UIKit

protocol MainTableViewProtocol: AnyObject {
    func deleteWorkout(model: WorkoutModel, index: Int)
}

class MainTableView: UITableView {
    
    weak var mainDelegate: MainTableViewProtocol?
    
    private var workoutArray = [WorkoutModel]()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        configure()
        setDelegates()
        register(WorkoutTableViewCell.self, forCellReuseIdentifier: WorkoutTableViewCell.idTableViewCell)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.backgroundColor = .none
        self.separatorStyle = .none
        self.bounces = false
        self.showsVerticalScrollIndicator = false
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setDelegates() {
        self.delegate = self
        self.dataSource = self
    }
    
    public func setWorkoutArray(array: [WorkoutModel]) {
        workoutArray = array
    }
    
}

//DATA SOURCE
extension MainTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        workoutArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: WorkoutTableViewCell.idTableViewCell, for: indexPath) as? WorkoutTableViewCell else { return UITableViewCell() }
        
        let workoutModel = workoutArray[indexPath.row]
        cell.configure(model: workoutModel)
        cell.workutCellDelegate = mainDelegate as? WorkoutTableViewCellProtocol 
        return cell
    }
}

//DELEGATE
extension MainTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "") { [weak self] _, _, _ in
            //action
            guard let self = self else {return}
            let deleteModel = self.workoutArray[indexPath.row]
            self.mainDelegate?.deleteWorkout(model: deleteModel, index: indexPath.row)
        }
        
        action.backgroundColor = .specialBackground
        action.image = UIImage(named: "delete")
        
        return UISwipeActionsConfiguration(actions: [action])
    }
}



