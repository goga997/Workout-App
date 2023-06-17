//
//  DateRepeatView.swift
//  TrainingApp
//
//  Created by Grigore on 17.06.2023.
//

import UIKit

class DateRepeatView: UIView {
    
    private let dateRepeatLabel = UILabel(text: "Date and Repeat")
    
    private let backSubView: UIView = {
       let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .specialBrown
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dateLabel: UILabel = {
       let label = UILabel()
        label.text = "Date"
        label.textColor = .specialGray
        label.font = .robotoMedium18()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let repeatSevenLabel: UILabel = {
       let label = UILabel()
        label.text = "Repeat every 7 days"
        label.textColor = .specialGray
        label.font = .robotoMedium18()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var repeatOnSwitch: UISwitch = {
       let repeatSwitch = UISwitch()
        repeatSwitch.isOn = true
        repeatSwitch.onTintColor = .specialGreen
        repeatSwitch.addTarget(self, action: #selector(switchAction), for: .valueChanged)
        repeatSwitch.translatesAutoresizingMaskIntoConstraints = false
        return repeatSwitch
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePick = UIDatePicker()
        datePick.datePickerMode = .date
        datePick.tintColor = .specialGreen
        datePick.translatesAutoresizingMaskIntoConstraints = false
        return datePick
    }()
    
    private var dateStackView = UIStackView()
    private var repeatSevenDayStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func switchAction() {
        print("working")
    }
    
    private func setUpView() {
        backgroundColor = .none
        translatesAutoresizingMaskIntoConstraints = false

        addSubview(dateRepeatLabel)
        addSubview(backSubView)
        
        dateStackView = UIStackView(arrangedSubviews: [dateLabel, datePicker], axis: .horizontal, distribution: .equalSpacing)
        backSubView.addSubview(dateStackView)
        
        repeatSevenDayStackView = UIStackView(arrangedSubviews: [repeatSevenLabel, repeatOnSwitch], axis: .horizontal, distribution: .equalSpacing)
        backSubView.addSubview(repeatSevenDayStackView)
    }
        
    private func setConstraints() {
        NSLayoutConstraint.activate([
            dateRepeatLabel.topAnchor.constraint(equalTo: self.topAnchor),
            dateRepeatLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            dateRepeatLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            dateRepeatLabel.heightAnchor.constraint(equalToConstant: 15),
            
            backSubView.topAnchor.constraint(equalTo: dateRepeatLabel.bottomAnchor, constant: 3),
            backSubView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backSubView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backSubView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            dateStackView.topAnchor.constraint(equalTo: backSubView.topAnchor, constant: 10),
            dateStackView.leadingAnchor.constraint(equalTo: backSubView.leadingAnchor, constant: 10),
            dateStackView.trailingAnchor.constraint(equalTo: backSubView.trailingAnchor, constant: -10),
            dateStackView.heightAnchor.constraint(equalTo: backSubView.heightAnchor, multiplier: 0.4),
            
            repeatSevenDayStackView.topAnchor.constraint(equalTo: dateStackView.bottomAnchor, constant: 10),
            repeatSevenDayStackView.leadingAnchor.constraint(equalTo: backSubView.leadingAnchor, constant: 10),
            repeatSevenDayStackView.trailingAnchor.constraint(equalTo: backSubView.trailingAnchor, constant: -10),
            repeatSevenDayStackView.heightAnchor.constraint(equalTo: backSubView.heightAnchor, multiplier: 0.4),
            
        ])
    }
}
