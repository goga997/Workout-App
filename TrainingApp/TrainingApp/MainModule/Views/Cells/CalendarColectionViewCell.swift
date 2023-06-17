//
//  CalendarColectionViewCell.swift
//  TrainingApp
//
//  Created by Grigore on 08.06.2023.
//

import UIKit

class CalendarColectionViewCell: UICollectionViewCell {
    
    private let dayOfWeekLabel: UILabel = {
       let label = UILabel()
        label.text = "Mo"
        label.font = .robotoBold16()
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let numberOfDayLabel: UILabel = {
       let label = UILabel()
        label.text = "23"
        label.font = .robotoBold20()
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override var isSelected: Bool  {
        didSet {
            if self.isSelected {
                self.backgroundColor = .specialYellow
                dayOfWeekLabel.textColor = .specialBlack
                numberOfDayLabel.textColor = .specialDarkGreen
            } else {
                self.backgroundColor = .none
                dayOfWeekLabel.textColor = .white
                numberOfDayLabel.textColor = .white
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        self.layer.cornerRadius = 10
        
        self.addSubview(dayOfWeekLabel)
        self.addSubview(numberOfDayLabel)
    }
}

//MARK: - Layouts

extension CalendarColectionViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            dayOfWeekLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            dayOfWeekLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 7),
            
            numberOfDayLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            numberOfDayLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
    }
}
