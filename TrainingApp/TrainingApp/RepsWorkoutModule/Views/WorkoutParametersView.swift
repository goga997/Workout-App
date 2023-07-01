//
//  WorkoutParametersView.swift
//  TrainingApp
//
//  Created by Grigore on 01.07.2023.
//

import UIKit

protocol NextSetProtocol: AnyObject {
    func nextSetTapped()
    func editingTapped()
}

class WorkoutParametersView: UIView {
    
    weak var delegate: NextSetProtocol?
    
    private let nameWorkoutLabel = UILabel(text: "Biceps", font: .robotoBold24(), textColor: .specialGray)
    
    private let setsLabel = UILabel(text: "Sets", font: .robotoMedium18(), textColor: .specialGray)
    
    private let numberSets = UILabel(text: "1/4", font: .robotoMedium24(), textColor: .specialGray)
    
    private let contextLabel = UILabel(text: "Reps", font: .robotoMedium18(), textColor: .specialGray)
    
    private let numberReps = UILabel(text: "20", font: .robotoMedium24(), textColor: .specialGray)
    
    private let lineDownView: UIView = {
       let view = UIView()
        view.backgroundColor = .specialLine
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let lineDownViewSecond: UIView = {
       let view = UIView()
        view.backgroundColor = .specialLine
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var editingButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .none
        button.tintColor = .specialGray
        button.setTitle("Editing", for: .normal)
        button.titleLabel?.font = .robotoMedium16()
        button.setImage(UIImage(named: "editing"), for: .normal)
        button.addTarget(self, action: #selector(editingButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var nextSeTButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT SET", for: .normal)
        button.backgroundColor = .specialDarkYellow
        button.setTitleColor(.specialDarkGreen, for: .normal)
//        button.addShadowToView()
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .robotoBold16()
        button.addTarget(self, action: #selector(nextSetButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - INITIALIZATION
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setConstraints()
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUpView() {
        backgroundColor = .specialBrown
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
        numberSets.textAlignment = .right
        numberReps.textAlignment = .right
    
        self.addSubview(nameWorkoutLabel)
        self.addSubview(setsLabel)
        self.addSubview(numberSets)
        self.addSubview(lineDownView)
        self.addSubview(contextLabel)
        self.addSubview(numberReps)
        self.addSubview(lineDownViewSecond)
        self.addSubview(editingButton)
        self.addSubview(nextSeTButton)
    }
    
    @objc private func nextSetButtonTapped() {
        delegate?.nextSetTapped()
    }
    
    @objc private func editingButtonTapped() {
        delegate?.editingTapped()
    }
    
    public func refreshLabelsValue(model: WorkoutModel, numberOfSet: Int) {
        nameWorkoutLabel.text = model.workoutName
        numberSets.text = "\(numberOfSet)/\(model.workoutSets)"
        numberReps.text = "\(model.workoutReps)"
    }
}

extension WorkoutParametersView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            nameWorkoutLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nameWorkoutLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            
            setsLabel.topAnchor.constraint(equalTo: nameWorkoutLabel.bottomAnchor, constant: 20),
            setsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            setsLabel.widthAnchor.constraint(equalToConstant: 60),
            
            numberSets.topAnchor.constraint(equalTo: nameWorkoutLabel.bottomAnchor, constant: 16),
            numberSets.leadingAnchor.constraint(equalTo: setsLabel.trailingAnchor),
            numberSets.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            
            lineDownView.topAnchor.constraint(equalTo: setsLabel.bottomAnchor, constant: 4),
            lineDownView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            lineDownView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            lineDownView.heightAnchor.constraint(equalToConstant: 1),
            
            contextLabel.topAnchor.constraint(equalTo: lineDownView.bottomAnchor, constant: 30),
            contextLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            contextLabel.widthAnchor.constraint(equalToConstant: 60),
            
            numberReps.topAnchor.constraint(equalTo: lineDownView.bottomAnchor, constant: 25),
            numberReps.leadingAnchor.constraint(equalTo: contextLabel.trailingAnchor),
            numberReps.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            
            lineDownViewSecond.topAnchor.constraint(equalTo: contextLabel.bottomAnchor, constant: 4),
            lineDownViewSecond.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            lineDownViewSecond.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            lineDownViewSecond.heightAnchor.constraint(equalToConstant: 1),
            
            editingButton.topAnchor.constraint(equalTo: lineDownViewSecond.bottomAnchor, constant: 12),
            editingButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            editingButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25),
            editingButton.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.07),
            
            nextSeTButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            nextSeTButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nextSeTButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85),
            nextSeTButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.16)
        ])
    }
}
