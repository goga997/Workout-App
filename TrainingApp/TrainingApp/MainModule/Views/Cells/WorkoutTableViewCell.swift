//
//  WorkoutTableViewCell.swift
//  TrainingApp
//
//  Created by Grigore on 14.06.2023.
//

import UIKit


class WorkoutTableViewCell: UITableViewCell {
                
    static let idTableViewCell = "idTableViewCell"
    
    private let backgroundCell: UIView = {
       let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .specialBrown
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let backgroundImageCell: UIView = {
       let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .specialBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let workoutImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "testWorkout")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let workoutNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Pull ups"
        label.textColor = .specialBlack
        label.font = .robotoMedium22()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let workoutRepsNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Reps: 20"
        label.textColor = .specialGray
        label.font = .robotoMedium16()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let workoutSetsNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Sets 2"
        label.textColor = .specialGray
        label.font = .robotoMedium16()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("START", for: .normal)
        button.backgroundColor = .specialYellow
        button.setTitleColor(.specialDarkGreen, for: .normal)
        button.addShadowToView()
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .robotoBold16()
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var labelsStackView = UIStackView()
    
    //MARK: - INITIALIZATION
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //SETUP VIEW
    private func setUpViews() {
        backgroundColor = .clear
        selectionStyle = .none
        
        addSubview(backgroundCell)
        backgroundCell.addSubview(backgroundImageCell)
        backgroundImageCell.addSubview(workoutImageView)
        backgroundCell.addSubview(workoutNameLabel)
        
        labelsStackView = UIStackView(arrangedSubviews: [workoutRepsNameLabel, workoutSetsNameLabel],
                                      axis: .horizontal,
                                      spacing: 10)
        backgroundCell.addSubview(labelsStackView)
        
        contentView.addSubview(startButton)
    }
    
    @objc private func startButtonTapped() {
        
    }
    
}

//MARK: - CONSTRAINTS

extension WorkoutTableViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundCell.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            backgroundCell.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            backgroundCell.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            backgroundCell.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            backgroundImageCell.centerYAnchor.constraint(equalTo: backgroundCell.centerYAnchor),
            backgroundImageCell.leadingAnchor.constraint(equalTo: backgroundCell.leadingAnchor, constant: 10),
            backgroundImageCell.heightAnchor.constraint(equalToConstant: 70),
            backgroundImageCell.widthAnchor.constraint(equalTo: backgroundImageCell.heightAnchor),
            
            workoutImageView.topAnchor.constraint(equalTo: backgroundImageCell.topAnchor, constant: 10),
            workoutImageView.leadingAnchor.constraint(equalTo: backgroundImageCell.leadingAnchor, constant: 10),
            workoutImageView.trailingAnchor.constraint(equalTo: backgroundImageCell.trailingAnchor, constant: -10),
            workoutImageView.bottomAnchor.constraint(equalTo: backgroundImageCell.bottomAnchor, constant: -10),
            
            workoutNameLabel.topAnchor.constraint(equalTo: backgroundCell.topAnchor, constant: 5),
            workoutNameLabel.leadingAnchor.constraint(equalTo: backgroundImageCell.trailingAnchor, constant: 10),
            workoutNameLabel.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -10),
            
            labelsStackView.topAnchor.constraint(equalTo: workoutNameLabel.bottomAnchor, constant: 0),
            labelsStackView.leadingAnchor.constraint(equalTo: backgroundImageCell.trailingAnchor, constant: 10),
            labelsStackView.heightAnchor.constraint(equalToConstant: 20),
            
            startButton.topAnchor.constraint(equalTo: labelsStackView.bottomAnchor, constant: 5),
            startButton.leadingAnchor.constraint(equalTo: backgroundImageCell.trailingAnchor, constant: 10),
            startButton.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor,constant: -10),
            startButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}

