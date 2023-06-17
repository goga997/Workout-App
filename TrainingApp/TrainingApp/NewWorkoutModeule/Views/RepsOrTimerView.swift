//
//  RepsOrTimerView.swift
//  TrainingApp
//
//  Created by Grigore on 17.06.2023.
//

import UIKit

class RepsOrTimerView: UIView {
    
    private let repsOrTimerLabel = UILabel(text: "Reps or Timer")
    
    private let backSubView: UIView = {
       let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .specialBrown
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let setsLabel: UILabel = {
       let label = UILabel()
        label.text = "Sets"
        label.textColor = .specialGray
        label.font = .robotoMedium18()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let repsLabel: UILabel = {
       let label = UILabel()
        label.text = "Reps"
        label.textColor = .specialGray
        label.font = .robotoMedium18()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timerLabel: UILabel = {
       let label = UILabel()
        label.text = "Timer"
        label.textColor = .specialGray
        label.font = .robotoMedium18()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let setsNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "4"
        label.font = .robotoMedium24()
        label.textColor = .specialGray
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let repsNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "6"
        label.font = .robotoMedium24()
        label.textColor = .specialGray
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timerNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "1 min 30 sec"
        label.font = .robotoMedium24()
        label.textColor = .specialGray
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let chooseRepOrTimeLabel: UILabel = {
       let label = UILabel(text: "Choose repeat or timer")
        label.textAlignment = .center
       return label
    }()
    
    private lazy var setsSlider = GreenSlider(minimumValue: 0, maximumValue: 10)
    private lazy var repsSlider = GreenSlider(minimumValue: 0, maximumValue: 50)
    private lazy var timerSlider = GreenSlider(minimumValue: 0, maximumValue: 600)

    private var setskStackView = UIStackView()  //horrizontal
    private var repsStackView = UIStackView()   //horrizontal
    private var timerStackView = UIStackView()  //horrizontal
    
    private var setsVerticalSV = UIStackView()
    private var repsVerticalSV = UIStackView()
    private var timerVerticalSV = UIStackView()
    
    private var verticalModuleStackView = UIStackView()     //all objects, full view
    
    //MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpView() {
        backgroundColor = .none
        translatesAutoresizingMaskIntoConstraints = false

        addSubview(repsOrTimerLabel)
        addSubview(backSubView)

        setskStackView = UIStackView(arrangedSubviews: [setsLabel, setsNumberLabel], axis: .horizontal, distribution: .equalSpacing)
        repsStackView = UIStackView(arrangedSubviews: [repsLabel, repsNumberLabel], axis: .horizontal, distribution: .equalSpacing)
        timerStackView = UIStackView(arrangedSubviews: [timerLabel, timerNumberLabel], axis: .horizontal, distribution: .equalSpacing)
        
        setsVerticalSV = UIStackView(arrangedSubviews: [setskStackView, setsSlider], axis: .vertical, spacing: 6)
        repsVerticalSV = UIStackView(arrangedSubviews: [repsStackView, repsSlider], axis: .vertical, spacing: 6)
        timerVerticalSV = UIStackView(arrangedSubviews: [timerStackView, timerSlider], axis: .vertical, spacing: 6)
        
        verticalModuleStackView = UIStackView(arrangedSubviews: [setsVerticalSV, chooseRepOrTimeLabel, repsVerticalSV, timerVerticalSV], axis: .vertical, distribution: .equalSpacing)
        backSubView.addSubview(verticalModuleStackView)
    }
        
    private func setConstraints() {
        NSLayoutConstraint.activate([
            repsOrTimerLabel.topAnchor.constraint(equalTo: self.topAnchor),
            repsOrTimerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            repsOrTimerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            repsOrTimerLabel.heightAnchor.constraint(equalToConstant: 15),
            
            backSubView.topAnchor.constraint(equalTo: repsOrTimerLabel.bottomAnchor, constant: 3),
            backSubView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backSubView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backSubView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            verticalModuleStackView.topAnchor.constraint(equalTo: backSubView.topAnchor, constant: 20),
            verticalModuleStackView.leadingAnchor.constraint(equalTo: backSubView.leadingAnchor, constant: 10),
            verticalModuleStackView.trailingAnchor.constraint(equalTo: backSubView.trailingAnchor, constant: -15),
            verticalModuleStackView.bottomAnchor.constraint(equalTo: backSubView.bottomAnchor, constant: -20)
        ])
    }
}
