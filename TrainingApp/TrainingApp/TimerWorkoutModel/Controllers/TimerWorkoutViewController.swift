//
//  TimerWorkoutViewController.swift
//  TrainingApp
//
//  Created by Grigore on 01.07.2023.
//

import UIKit

class TimerWorkoutViewController: UIViewController {
    
    private let startWorkoutLabel = UILabel(text: "START WORKOUT", font: .robotoBold24(), textColor: .specialGray)
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "closeButton"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let timerIndicator: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "ellipse")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let timerLabel: UILabel = {
       let label = UILabel()
        label.text = "09:22"
        label.textColor = .specialGray
        label.font = .robotoBold48()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let detailsLabel = UILabel(text: "Detailes")
    private lazy var finishButton = GreenButton(text: "FINISH")
    
    private let infoView = TimerWorkoutParametersView()
    private var workoutModel = WorkoutModel()
    private var customAlert = CustomAlert()
    
    private var timer = Timer()
    private let shapeLayer = CAShapeLayer()
    private var durationTimer = 10
    private var numberOfSet = 0
    
    //MARK: - LIFE CYCLE + viewSetUp
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setConstraints()
        addTapOnTheTimer()
        setWorkoutParameters()
    }
    
    override func viewDidLayoutSubviews() {
        animationCircular()
    }
    
    //MARK: - SetUpView
    private func setUpView() {
        view.backgroundColor = .specialBackground
        
        view.addSubview(startWorkoutLabel)
        view.addSubview(closeButton)
        view.addSubview(timerIndicator)
        view.addSubview(timerLabel)
        view.addSubview(detailsLabel)
        infoView.refreshLabelsValue(model: workoutModel, numberOfSet: numberOfSet)
        
        view.addSubview(infoView)
        infoView.timerDelegate = self
        
        view.addSubview(finishButton)
        finishButton.addTarget(self, action: #selector(finishButtonTapped), for: .touchUpInside)
    }

    
    public func setWorkoutModel(_ model: WorkoutModel) {
        workoutModel = model
    }
    
    private func addTapOnTheTimer() {
        let tapLabel = UITapGestureRecognizer(target: self, action: #selector(startTimer))
        timerLabel.isUserInteractionEnabled = true
        timerLabel.addGestureRecognizer(tapLabel)
    }

//Timer Functions
    @objc private func startTimer() {
        
        if numberOfSet == workoutModel.workoutSets {
            presentSimpleAlert(title: "Workout Done", message: "Finish your workout\nYou can not go further")
        } else {
            infoView.buttonsIsEnable(false)
            timerLabel.isUserInteractionEnabled = false
            basicAnimation()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        }
    }
    
    @objc private func timerAction() {
        durationTimer -= 1
        
        if durationTimer == 0 {
            timer.invalidate()
            durationTimer = workoutModel.workoutTimer

            numberOfSet += 1
            infoView.refreshLabelsValue(model: workoutModel, numberOfSet: numberOfSet)
            infoView.buttonsIsEnable(true)
            timerLabel.isUserInteractionEnabled = true
        }
        
        let (min, sec) = durationTimer.convertSecond()
        timerLabel.text = "\(min):\(sec.addZeroIfValueLessNine())"
    }

//Close Button
    @objc private func closeButtonTapped() {
        timer.invalidate()
        dismiss(animated: true)
    }
    
    @objc private func finishButtonTapped() {
        if numberOfSet == workoutModel.workoutSets {
            dismiss(animated: true)
            RealmManager.shared.setTrueStatusWorkoutModelForFinish(model: workoutModel)
        } else {
            self.presentAlertForFinishButton(title: "Warning",
                                             message: "You have not finished your workout") {
                self.dismiss(animated: true)
            }
        }
    }

// Set workout
    private func setWorkoutParameters() {
        let (min, sec) = workoutModel.workoutTimer.convertSecond()
        timerLabel.text = "\(min):\(sec.addZeroIfValueLessNine())"
        durationTimer = workoutModel.workoutTimer
    }
}

//MARK: - ANIMATION
extension TimerWorkoutViewController {
    private func  animationCircular() {
        let center = CGPoint(x: timerIndicator.frame.width / 2,
                             y: timerIndicator.frame.height / 2)
        
        let endAngle = (-CGFloat.pi / 2)
        let startAngle = 2 * CGFloat.pi + endAngle
        let radius = timerIndicator.frame.width * 0.4652014 //127
        
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.lineWidth = 21
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.specialGreen.cgColor
        shapeLayer.strokeEnd = 1
        shapeLayer.lineCap = .round
        timerIndicator.layer.addSublayer(shapeLayer)
    }
    
    private func basicAnimation() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 0
        basicAnimation.duration = CFTimeInterval(durationTimer)
        basicAnimation.isRemovedOnCompletion = true
        shapeLayer.add(basicAnimation, forKey: "basicAnimation")   //the key does not matter
    }
}


//MARK: - TimerNExtSet+Editing Protocol

extension TimerWorkoutViewController: NextSetTimerProtocol {
    func nextSetTapped() {
        if numberOfSet < workoutModel.workoutSets {
            numberOfSet += 1
            infoView.refreshLabelsValue(model: workoutModel, numberOfSet: numberOfSet)
        } else {
            presentSimpleAlert(title: "Workout Done", message: "You have to finish your Workout")
        }
    }
    
    func editingTimerButtonTapped() {
        customAlert.presentCustomAlert(viewController: self, repsOrTimer: "Timer of Set ") { [weak self] sets, timer in
            guard let self = self else { return }
            if sets != "" && timer != "" {
                guard let numberOfSets = Int(sets), let timerValue = Int(timer) else { return }
                RealmManager.shared.updateSetsTimerWorkoutModel(model: self.workoutModel, sets: numberOfSets, timer: timerValue)
                
                let (min, sec) = timerValue.convertSecond()
                self.timerLabel.text = "\(min):\(sec.addZeroIfValueLessNine())"
                self.durationTimer = timerValue
                
                self.infoView.refreshLabelsValue(model: self.workoutModel, numberOfSet: self.numberOfSet)
            }
        }
    }
    
    
}

//MARK: - Layouts
extension TimerWorkoutViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            startWorkoutLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            startWorkoutLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            closeButton.centerYAnchor.constraint(equalTo: startWorkoutLabel.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            closeButton.heightAnchor.constraint(equalToConstant: 33),
            closeButton.widthAnchor.constraint(equalTo: closeButton.heightAnchor),
            
            
            timerIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerIndicator.topAnchor.constraint(equalTo: startWorkoutLabel.bottomAnchor, constant: 30),
            timerIndicator.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            timerIndicator.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            
            timerLabel.centerXAnchor.constraint(equalTo: timerIndicator.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: timerIndicator.centerYAnchor),
            timerLabel.widthAnchor.constraint(equalTo: timerIndicator.widthAnchor, multiplier: 0.6),
            timerLabel.heightAnchor.constraint(equalTo: timerIndicator.heightAnchor, multiplier: 0.6),
            
            
            detailsLabel.topAnchor.constraint(equalTo: timerIndicator.bottomAnchor, constant: 30),
            detailsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            detailsLabel.widthAnchor.constraint(equalToConstant: 60),
            detailsLabel.heightAnchor.constraint(equalToConstant: 15),
            
            infoView.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 3),
            infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            infoView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65),
            
            finishButton.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 25),
            finishButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            finishButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            finishButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.135)
        ])
    }
}

