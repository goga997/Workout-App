//
//  ViewController.swift
//  TrainingApp
//
//  Created by Grigore on 07.06.2023.
//

import UIKit

class MainViewController: UIViewController {

    private let userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.8044065833, green: 0.8044064641, blue: 0.8044064641, alpha: 1)
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Grigore Rosca"
        label.font = .robotoMedium24()
        label.textColor = .specialGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var addWorkOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .specialYellow
        button.layer.cornerRadius = 10
        button.tintColor = .specialDarkGreen
        button.setTitle("Add workout", for: .normal)
        button.imageEdgeInsets = .init(top: 0,
                                       left: 18,
                                       bottom: 15,
                                       right: 0)
        button.titleEdgeInsets = .init(top: 50,
                                       left: -40,
                                       bottom: 0,
                                       right: 0)
        button.addShadowToView()
        button.titleLabel?.font = .robotoMedium12()
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.addTarget(self, action: #selector(addWorkoutTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let calendarViewGreen = CalendarViewGreen()
    private let weatherView = WeatherView()
    private let workoutTodayLabel = UILabel(text: "Workout Today")
    private let mainTableView = MainTableView()
    
    // MARK: - Life Cycle
    
    override func viewDidLayoutSubviews() {
        userPhotoImageView.layer.cornerRadius = userPhotoImageView.frame.height / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setLayouts()
    }
    
    //MARK: Functionality
    
    @objc private func addWorkoutTapped() {
        let newWorkoutVC = NewWorkoutViewController()
        newWorkoutVC.modalPresentationStyle = .fullScreen
        present(newWorkoutVC, animated: true)
    }
    
}

//MARK: - Layouts

typealias MainViewControllerLayouts = MainViewController
extension MainViewControllerLayouts {
    
    private func setUpViews() {
        view.backgroundColor = .specialBackground
        
        view.addSubview(calendarViewGreen)
        view.addSubview(userPhotoImageView)
        view.addSubview(userNameLabel)
        view.addSubview(addWorkOutButton)
        view.addSubview(weatherView)
        view.addSubview(workoutTodayLabel)
        view.addSubview(mainTableView)
    }
    
    private func setLayouts() {
        setUpUserPhotoImageViewLayouts()
        setUpCalendarViewGreenLayouts()
        setUpUserNameLabeleLayouts()
        setUpAddWorkoutButtonLayouts()
        setUpWeatherViewLayouts()
        setUpWorkoutLabelLayouts()
        setUpMainTableView()
    }

    private func setUpUserPhotoImageViewLayouts() {
        NSLayoutConstraint.activate([
            userPhotoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            userPhotoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            userPhotoImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25),
            userPhotoImageView.widthAnchor.constraint(equalTo: userPhotoImageView.heightAnchor)
        ])
    }
    
    private func setUpCalendarViewGreenLayouts() {
        NSLayoutConstraint.activate([
            calendarViewGreen.topAnchor.constraint(equalTo: userPhotoImageView.centerYAnchor),
            calendarViewGreen.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            calendarViewGreen.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
//            calendarViewGreen.heightAnchor.constraint(equalToConstant: 70),
            calendarViewGreen.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.17)
        ])
    }
    
    private func setUpUserNameLabeleLayouts() {
        NSLayoutConstraint.activate([
            userNameLabel.bottomAnchor.constraint(equalTo: calendarViewGreen.topAnchor, constant: -10),
            userNameLabel.leadingAnchor.constraint(equalTo: userPhotoImageView.trailingAnchor, constant: 5)
        ])
    }
    
    private func setUpAddWorkoutButtonLayouts() {
        NSLayoutConstraint.activate([
            addWorkOutButton.topAnchor.constraint(equalTo: calendarViewGreen.bottomAnchor, constant: 5),
            addWorkOutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            addWorkOutButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2),
            addWorkOutButton.widthAnchor.constraint(equalTo: addWorkOutButton.heightAnchor)
        ])
    }
    
    private func setUpWeatherViewLayouts() {
        NSLayoutConstraint.activate([
            weatherView.topAnchor.constraint(equalTo: calendarViewGreen.bottomAnchor, constant: 5),
            weatherView.leadingAnchor.constraint(equalTo: addWorkOutButton.trailingAnchor, constant: 10),
            weatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
//            weatherView.heightAnchor.constraint(equalToConstant: 80)
            weatherView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2)
        ])
    }
    
    private func setUpWorkoutLabelLayouts() {
        NSLayoutConstraint.activate([
            workoutTodayLabel.topAnchor.constraint(equalTo: addWorkOutButton.bottomAnchor, constant: 15),
            workoutTodayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            workoutTodayLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
    }

    private func setUpMainTableView() {
        NSLayoutConstraint.activate([
            mainTableView.topAnchor.constraint(equalTo: workoutTodayLabel.bottomAnchor, constant: 5),
            mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension MainViewController: CellActionDelegate {
    func didButtonTapped() {
        let startVC = StartWorkoutRepsViewController()
        startVC.modalPresentationStyle = .fullScreen
        present(startVC, animated: true)
    }
    
    
}
