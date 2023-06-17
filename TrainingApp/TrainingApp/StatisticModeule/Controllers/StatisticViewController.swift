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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setConstarints()
    }
    
    private func setUpView() {
        view.backgroundColor = .specialBackground
        
        view.addSubview(statisticLabelTop)
        view.addSubview(segmentedControll)
        view.addSubview(exercicesLabel)
        view.addSubview(statisticTableView)
    }

    @objc private func segmentChanged() {
        
        if segmentedControll.selectedSegmentIndex == 0 {
            print("week selected")
        } else {
            print("month selected")
        }
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
