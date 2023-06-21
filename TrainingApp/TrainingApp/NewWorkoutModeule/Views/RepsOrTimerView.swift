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
    
    private let setsView = SliderView(name: "Sets", minValue: 0, maxValue: 10, type: .sets)
    private let repsView = SliderView(name: "Reps", minValue: 0, maxValue: 50, type: .reps)
    private let timerView = SliderView(name: "Timer", minValue: 0, maxValue: 600, type: .timer)
    private let chooseRepOrTimeLabel = UILabel(text: "Choose repeat or timer")
    private var verticalStackView = UIStackView()    // all sliderViews (grouped), vertically stacked + label(between)
    
    public var (sets, reps, timer) = (0, 0, 0)   //local storage of data that came from SliderView in changeValueMethod

    //MARK: - Initialization + setUpViews
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setConstraints()
        setDelegates()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpView() {
        backgroundColor = .none
        translatesAutoresizingMaskIntoConstraints = false
        chooseRepOrTimeLabel.textAlignment = .center
        
        addSubview(repsOrTimerLabel)
        addSubview(backSubView)

        verticalStackView = UIStackView(arrangedSubviews: [setsView, chooseRepOrTimeLabel, repsView, timerView], axis: .vertical, spacing: 5)
        
        backSubView.addSubview(verticalStackView)
    }
    
    private func setDelegates() {
        setsView.delegate = self
        repsView.delegate = self
        timerView.delegate = self
    }
    
    //reset sliders after succes saving
    public func resetSliders() {
        setsView.modifySliderWhenSaved()
        repsView.modifySliderWhenSaved()
        timerView.modifySliderWhenSaved()
    }
    

//MARK: - LAYOUTS
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
            
            verticalStackView.topAnchor.constraint(equalTo: backSubView.topAnchor, constant: 10),
            verticalStackView.leadingAnchor.constraint(equalTo: backSubView.leadingAnchor, constant: 10),
            verticalStackView.trailingAnchor.constraint(equalTo: backSubView.trailingAnchor, constant: -15),
            verticalStackView.bottomAnchor.constraint(equalTo: backSubView.bottomAnchor, constant: -10)
        ])
    }
}

//MARK: - Slider Protocol

extension RepsOrTimerView: SliderViewProtoc {
    func changeValue(type: SliderTypes, value: Int) {
        switch type {
            
        case .sets:
            sets = value
        case .reps:
            reps = value
            repsView.isActive = true
            timerView.isActive = false
            timer = 0
        case .timer:
            timer = value
            timerView.isActive = true
            repsView.isActive = false
            reps = 0
        }
    }
    
    
}
