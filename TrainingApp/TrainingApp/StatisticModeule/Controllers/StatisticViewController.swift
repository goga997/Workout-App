//
//  StatisticViewController.swift
//  TrainingApp
//
//  Created by Grigore on 15.06.2023.
//

import UIKit

class StatisticViewController: UIViewController {

    private let statisticLabelTop: UILabel = {
       let label = UILabel()
        label.font = .robotoBold24()
        label.text = "STATISTICS"
        label.textColor = .specialGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var segmentedControll: UISegmentedControl = {
       let segControll = UISegmentedControl(items: ["Week", "Month"])
        segControll.selectedSegmentIndex = 0
        segControll.backgroundColor = .specialGreen
        segControll.selectedSegmentTintColor = .specialYellow
        
        let font = UIFont(name: "Roboto-Medium", size: 14)
        segControll.setTitleTextAttributes([.font : font as Any, .foregroundColor : UIColor.white], for: .normal)
        segControll.setTitleTextAttributes([.font : font as Any, .foregroundColor : UIColor.specialDarkGreen], for: .selected)
        
        segControll.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        segControll.translatesAutoresizingMaskIntoConstraints = false
        return segControll
    }()
    
    private let exercicesLabel = UILabel(text: "Exercices")
    private let statisticTableView = StatisticTableView()
    
    private var workoutArray = [WorkoutModel]()
    private var differenceArray = [DifferenceWorkout]()

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setConstarints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setStartScreen()
    }
    
    //MARK: - Functionallity
    
    private func setUpView() {
        view.backgroundColor = .specialBackground
        
        view.addSubview(statisticLabelTop)
        view.addSubview(segmentedControll)
        view.addSubview(exercicesLabel)
        view.addSubview(statisticTableView)
    }

    @objc private func segmentChanged() {
        let todayDate = Date()
        differenceArray = [DifferenceWorkout]()
        
        if segmentedControll.selectedSegmentIndex == 0 {
            print("week selected")
            let dateStart = todayDate.offsetDays(day: 7)
            getDifferenceModel(dateStart: dateStart)
        } else {
            print("month selected")
            let dateStart = todayDate.offsetDate(month: 1)
            getDifferenceModel(dateStart: dateStart)
        }
        statisticTableView.reloadData()
    }
    
    private func getWorkoutName() -> [String] {
        var nameArray = [String]()
        
        let allWorkouts = RealmManager.shared.getObjectsWorkoutModel()
        
        for workoutModel in allWorkouts {
            if !nameArray.contains(workoutModel.workoutName) {
                nameArray.append(workoutModel.workoutName)
            }
        }
        return nameArray
    }
    
    private func getDifferenceModel(dateStart: Date) {
        let dateEnd = Date()
        let nameArray = getWorkoutName()
        let allWorkouts = RealmManager.shared.getObjectsWorkoutModel()
        
        for name in nameArray {
            let predicateDifference = NSPredicate(format: "workoutName = '\(name)' AND workoutDate BETWEEN %@", [dateStart, dateEnd])
            let filtredArray = allWorkouts.filter(predicateDifference).sorted(byKeyPath: "workoutDate")
            workoutArray = filtredArray.map { $0 }
            
            guard let last = workoutArray.last?.workoutReps,
                  let first = workoutArray.first?.workoutReps else { return }
            let differenceWorkout = DifferenceWorkout(name: name , firstReps: first, lastReps: last)
            differenceArray.append(differenceWorkout )
        }
        statisticTableView.setDifferenceArray(array: differenceArray)
    }
    
    private func setStartScreen() {
        let todayDate = Date()
        differenceArray = [DifferenceWorkout]()
        getDifferenceModel(dateStart: todayDate.offsetDays(day: 7))
        statisticTableView.reloadData()
    }
}


//LAYOUTS

extension StatisticViewController {
    private func setConstarints() {
        NSLayoutConstraint.activate([
            statisticLabelTop.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            statisticLabelTop.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            segmentedControll.topAnchor.constraint(equalTo: statisticLabelTop.bottomAnchor, constant: 20),
            segmentedControll.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControll.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            exercicesLabel.topAnchor.constraint(equalTo: segmentedControll.bottomAnchor, constant: 25),
            exercicesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            exercicesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            statisticTableView.topAnchor.constraint(equalTo: exercicesLabel.bottomAnchor, constant: 5),
            statisticTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            statisticTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            statisticTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
