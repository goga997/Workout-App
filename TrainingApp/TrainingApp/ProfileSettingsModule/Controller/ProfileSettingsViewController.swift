//
//  ProfileSettingsViewController.swift
//  TrainingApp
//
//  Created by Grigore on 11.07.2023.
//

import UIKit

class ProfileSettingsViewController: UIViewController {
    
    private let profileLabelTop: UILabel = {
        let label = UILabel()
        label.font = .robotoBold24()
        label.text = "EDITING"
        label.textColor = .specialGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.8044065833, green: 0.8044064641, blue: 0.8044064641, alpha: 1)
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 5
        imageView.clipsToBounds = true
        imageView.contentMode = .center
        imageView.image = UIImage(named: "addPhoto")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let greenView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialGreen
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "closeButton"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let firstNameLabel = UILabel(text: "   First Name")
    private let firstNameTextField = BrownTextField()
    
    private let lastNameLabel = UILabel(text: "   Last Name")
    private let lastNameTextField = BrownTextField()
    
    private let heightLabel = UILabel(text: "   Height")
    private let heightTextField = BrownTextField()
    
    private let weightLabel = UILabel(text: "   Weight")
    private let weightTextField = BrownTextField()
    
    private let targetLabel = UILabel(text: "   Target")
    private let targetTextField = BrownTextField()
    
    private var firstNameStackView = UIStackView()
    private var lastNameStackView = UIStackView()
    private var heightNameStackView = UIStackView()
    private var weightNameStackView = UIStackView()
    private var targetNameStackView = UIStackView()
    private var verticalGeneralStackView = UIStackView()
    
    private let saveButton = GreenButton(text: "SAVE")
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .none
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var userModel = UserModel()
    
    //MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setConstraints()
        registerKeyBoardNotification()
        tapImageView()
        loadUserInfo()
    }
    
    override func viewDidLayoutSubviews() {
        userPhotoImageView.layer.cornerRadius = userPhotoImageView.frame.height / 2
    }
    
    deinit {
        removeKeyBoardNotification()
    }
    
    //MARK: - setUpView + @objc
    private func setUpView() {
        scrollView.backgroundColor = .specialBackground
        
        view.addSubview(scrollView)
        scrollView.addSubview(backView)
        backView.addSubview(profileLabelTop)
        backView.addSubview(closeButton)
        backView.addSubview(greenView)
        backView.addSubview(userPhotoImageView)
        
        firstNameStackView = UIStackView(arrangedSubviews: [firstNameLabel, firstNameTextField], axis: .vertical, spacing: 3)
        lastNameStackView = UIStackView(arrangedSubviews: [lastNameLabel, lastNameTextField], axis: .vertical, spacing: 3)
        heightNameStackView = UIStackView(arrangedSubviews: [heightLabel, heightTextField], axis: .vertical, spacing: 3)
        weightNameStackView = UIStackView(arrangedSubviews: [weightLabel, weightTextField], axis: .vertical, spacing: 3)
        targetNameStackView = UIStackView(arrangedSubviews: [targetLabel, targetTextField], axis: .vertical, spacing: 3)
        verticalGeneralStackView = UIStackView(arrangedSubviews: [firstNameStackView,lastNameStackView, heightNameStackView, weightNameStackView, targetNameStackView], axis: .vertical, spacing: 20)
        
        backView.addSubview(verticalGeneralStackView)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        backView.addSubview(saveButton)
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func imageViewTapped() {
        
    }
    
    @objc private func saveButtonTapped() {
        setUserModel()
        
        let usersArray = RealmManager.shared.getUsersModel()
        if usersArray.count == 0 {
            RealmManager.shared.saveUserModel(userModel)
            self.presentSimpleAlert(title: "Saved", message: nil)
        } else {
            RealmManager.shared.updateUserModel(model: userModel)
            self.presentSimpleAlert(title: "Saved", message: nil)
        }
        
        userModel = UserModel()
    }
    
    private func tapImageView() {
        let tapImageView = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        userPhotoImageView.isUserInteractionEnabled = true
        userPhotoImageView.addGestureRecognizer(tapImageView)
    }
    
    private func setUserModel() {
        guard let firstName = firstNameTextField.text,
              let lastName = lastNameTextField.text,
              let height = heightTextField.text,
              let weight = weightTextField.text,
              let target = targetTextField.text else { return }
        
        guard let intHeight = Int(height),
              let intWeight = Int(weight),
              let intTarget = Int(target) else { return }
        
        userModel.userFirstName = firstName
        userModel.userLastName = lastName
        userModel.userHeight = intHeight
        userModel.userWeight = intWeight
        userModel.userTarget = intTarget
        
        if userPhotoImageView.image == UIImage(named: "addPhoto") {
            userModel.userImage = nil
        } else {
            guard let imageData = userPhotoImageView.image?.pngData() else { return }
            userModel.userImage = imageData
        }
    }
    
    private func loadUserInfo() {
        let userArray = RealmManager.shared.getUsersModel()
        
        if userArray.count != 0 {
            firstNameTextField.text = userArray[0].userFirstName
            lastNameTextField.text = userArray[0].userLastName
            heightTextField.text = "\(userArray[0].userHeight)"
            weightTextField.text = "\(userArray[0].userWeight)"
            targetTextField.text = "\(userArray[0].userTarget)"
            
            guard let data = userArray[0].userImage,
                  let image = UIImage(data: data) else { return }
            userPhotoImageView.image = image
            userPhotoImageView.contentMode = .scaleAspectFit
        }
    }
    
}

//MARK: - keyboard scroll
extension ProfileSettingsViewController {
    private func registerKeyBoardNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillDissapear),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        scrollView.contentOffset = CGPoint(x: 0, y: 165)
    }
    
    @objc private func keyboardWillDissapear(notification: Notification) {
        scrollView.contentOffset = CGPoint.zero
    }
    
    private func removeKeyBoardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

//MARK: - Layouts
extension ProfileSettingsViewController {
    func setConstraints() {
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            backView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            backView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            backView.heightAnchor.constraint(equalTo: view.heightAnchor),
            backView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            profileLabelTop.topAnchor.constraint(equalTo: backView.safeAreaLayoutGuide.topAnchor, constant: 10),
            profileLabelTop.centerXAnchor.constraint(equalTo: backView.centerXAnchor),
            
            closeButton.centerYAnchor.constraint(equalTo: profileLabelTop.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -25),
            closeButton.heightAnchor.constraint(equalToConstant: 33),
            closeButton.widthAnchor.constraint(equalTo: closeButton.heightAnchor),
            
            userPhotoImageView.topAnchor.constraint(equalTo: profileLabelTop.bottomAnchor, constant: 15),
            userPhotoImageView.centerXAnchor.constraint(equalTo: backView.centerXAnchor),
            userPhotoImageView.heightAnchor.constraint(equalTo: backView.widthAnchor, multiplier: 0.30),
            userPhotoImageView.widthAnchor.constraint(equalTo: userPhotoImageView.heightAnchor),
            
            greenView.topAnchor.constraint(equalTo: userPhotoImageView.centerYAnchor),
            greenView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 15),
            greenView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -15),
            greenView.heightAnchor.constraint(equalTo: backView.widthAnchor, multiplier: 0.19),
            
            firstNameTextField.heightAnchor.constraint(equalToConstant: 40),
            lastNameTextField.heightAnchor.constraint(equalToConstant: 40),
            heightTextField.heightAnchor.constraint(equalToConstant: 40),
            weightTextField.heightAnchor.constraint(equalToConstant: 40),
            targetTextField.heightAnchor.constraint(equalToConstant: 40),
            
            verticalGeneralStackView.topAnchor.constraint(equalTo: greenView.bottomAnchor, constant: 30),
            verticalGeneralStackView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 15),
            verticalGeneralStackView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -15),
            
            saveButton.topAnchor.constraint(equalTo: verticalGeneralStackView.bottomAnchor, constant: 50),
            saveButton.centerXAnchor.constraint(equalTo: backView.centerXAnchor),
            saveButton.widthAnchor.constraint(equalTo: backView.widthAnchor, multiplier: 0.80),
            saveButton.heightAnchor.constraint(equalTo: backView.widthAnchor, multiplier: 0.120)
        ])
    }
}
