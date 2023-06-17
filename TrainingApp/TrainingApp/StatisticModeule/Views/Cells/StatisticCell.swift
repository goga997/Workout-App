//
//  StatisticCell.swift
//  TrainingApp
//
//  Created by Grigore on 15.06.2023.
//

import UIKit

class StatisticCell: UITableViewCell {
    
    static let idCellStatistics = "idCellStatistics"
    
    private let workoutNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Biceps"
        label.textColor = .specialBlack
        label.font = .robotoMedium24()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statisticsBeforeNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "Before: 18"
        label.textColor = .specialLightBrown
        label.font = .robotoMedium14()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statisticsNowNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "Now: 20"
        label.textColor = .specialLightBrown
        label.font = .robotoMedium14()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let differenceLabel: UILabel = {
        let label = UILabel()
        label.text = "+2"
        label.textColor = .specialGreen
        label.font = .robotoMedium24()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let lineDownView: UIView = {
       let view = UIView()
        view.backgroundColor = .specialLine
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var labelsStackView = UIStackView()
    
        //MARK: -  INITIALIZATION
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: -
    
    private func setUpView() {
        backgroundColor = .clear
        selectionStyle = .none
        
        self.addSubview(workoutNameLabel)
        self.addSubview(differenceLabel)
        
        labelsStackView = UIStackView(arrangedSubviews: [statisticsBeforeNumberLabel, statisticsNowNumberLabel], axis: .horizontal, spacing: 10)
        self.addSubview(labelsStackView)
        
        self.addSubview(lineDownView)
    }
}

//MARK: - CONSTRAINTS
extension StatisticCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            differenceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            differenceLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            differenceLabel.widthAnchor.constraint(equalToConstant: 55),
            
            workoutNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            workoutNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            workoutNameLabel.trailingAnchor.constraint(equalTo: differenceLabel.leadingAnchor, constant: -10),
            
            labelsStackView.topAnchor.constraint(equalTo: workoutNameLabel.bottomAnchor, constant: 5),
            labelsStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            lineDownView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            lineDownView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            lineDownView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            lineDownView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
