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
    
    private let nameTextField = BrownTextField()
    
    private let exercicesLabel = UILabel(text: "Exercices")
    private let statisticTableView = StatisticTableView()
    
    private var workoutArray = [WorkoutModel]()
    private var differenceArray = [DifferenceWorkout]()
    private var filteredArray = [DifferenceWorkout]()
    
    private var isFiltered = false
    
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
        view.addSubview(nameTextField)
        nameTextField.brownTextFiealDelegate = self
        view.addSubview(exercicesLabel)
        view.addSubview(statisticTableView)
    }
    
    @objc private func segmentChanged() {
        let todayDate = Date()
        differenceArray = [DifferenceWorkout]()
        
        if segmentedControll.selectedSegmentIndex == 0 {
            //week
            let dateStart = todayDate.offsetDays(day: 7)
            getDifferenceModel(dateStart: dateStart)
        } else {
            //month
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
    
    private func filteringWorkouts(text: String) {
        for workout in differenceArray {
            if workout.name.lowercased().contains(text.lowercased()) {
                filteredArray.append(workout )
            }
        }
    }
}

//MARK: - BrownTExtFieldProtocol
extension StatisticViewController: BrownTextFieldProtocol {
    func typing(range: NSRange, replacementString: String) {
        //for getting allText
        if let text = nameTextField.text, let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: replacementString)

            filteredArray = [DifferenceWorkout]()
            isFiltered = updatedText.count > 0
            filteringWorkouts(text: updatedText)
        }
        
        if isFiltered {
            statisticTableView.setDifferenceArray(array: filteredArray)
        } else {
            statisticTableView.setDifferenceArray(array: differenceArray)
        }
        statisticTableView.reloadData()
    }
    
    func clear() {
        isFiltered = false
        differenceArray = [DifferenceWorkout]()
        let dateToday = Date().localDate()
            getDifferenceModel(dateStart: dateToday.offsetDays(day: 7))
            statisticTableView.reloadData()
    }
}

//MARK: - LAYOUTS
extension StatisticViewController {
    private func setConstarints() {
        NSLayoutConstraint.activate([
            statisticLabelTop.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            statisticLabelTop.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            segmentedControll.topAnchor.constraint(equalTo: statisticLabelTop.bottomAnchor, constant: 20),
            segmentedControll.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControll.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            nameTextField.topAnchor.constraint(equalTo: segmentedControll.bottomAnchor, constant: 15),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.041),
            
            exercicesLabel.topAnchor.constraint(equalTo: nameTextField .bottomAnchor, constant: 15),
            exercicesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            exercicesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            statisticTableView.topAnchor.constraint(equalTo: exercicesLabel.bottomAnchor, constant: 5),
            statisticTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            statisticTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            statisticTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
