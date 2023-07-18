//
//  ViewController.swift
//  TrainingApp
//
//  Created by Grigore on 07.06.2023.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    var latitude = ""
    var longitude = ""
    
    private let userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.8044065833, green: 0.8044064641, blue: 0.8044064641, alpha: 1)
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 5
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Grigore Rosca"
        label.font = .robotoMedium24()
        label.textColor = .specialGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var addWorkOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .specialYellow
        button.layer.cornerRadius = 10
        button.tintColor = .specialDarkGreen
        button.setTitle("Add workout", for: .normal)
        button.imageEdgeInsets = .init(top: 0,
                                       left: 18,
                                       bottom: 15,
                                       right: 0)
        button.titleEdgeInsets = .init(top: 50,
                                       left: -40,
                                       bottom: 0,
                                       right: 0)
        button.addShadowToView()
        button.titleLabel?.font = .robotoMedium12()
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.addTarget(self, action: #selector(addWorkoutTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let noWorkoutImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "noWorkout")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let calendarViewGreen = CalendarViewGreen()
    private let weatherView = WeatherView()
    private var workoutTodayLabel = UILabel(text: "Workout Today in ...")
    private let mainTableView = MainTableView()
    
    //Array that contains data from Realm
    private var workoutArray = [WorkoutModel]()
    
    // MARK: - Life Cycle
    
    override func viewDidLayoutSubviews() {
        userPhotoImageView.layer.cornerRadius = userPhotoImageView.frame.height / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setLayouts()
        
        if weatherView.weatherIcon.isHidden {
            weatherView.activityIndicator.startAnimating()
        }
        
        locationManager.requestWhenInUseAuthorization()
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                self.locationManager.startUpdatingLocation()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
//            print("Latitude: \(self.latitude), Longitude: \(self.longitude)")
            self.getWeather()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        selectItem(date: Date())
        mainTableView.reloadData()
        setUpUserparametters()
        
        if weatherView.weatherIcon.isHidden {
            weatherView.activityIndicator.startAnimating()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.getWeather()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showOnBoarding()
    }
    
    //MARK: Functionality
    
    private func showOnBoarding() {
        let userDefaults = UserDefaults.standard
        let onBoardingWasViewd = userDefaults.bool(forKey: "OnBoardingViewed")
        
        if onBoardingWasViewd == false {
            let onBoarding = OnBoardingViewController()
            onBoarding.modalPresentationStyle = .fullScreen
            present(onBoarding, animated: true)
        }
    }
    
    @objc private func addWorkoutTapped() {
        let newWorkoutVC = NewWorkoutViewController()
        newWorkoutVC.modalPresentationStyle = .fullScreen
        present(newWorkoutVC, animated: true)
    }
    
    private func checkWorkoutToday() {
        //        if workoutArray.count == 0 {
        //            noWorkoutImageView.isHidden = false
        //            mainTableView.isHidden = true
        //        } else {
        //            noWorkoutImageView.isHidden = true
        //            mainTableView.isHidden = false
        //        }
        noWorkoutImageView.isHidden = !workoutArray.isEmpty
        mainTableView.isHidden = workoutArray.isEmpty
    }
    
    private func getWorkouts(date: Date) {
        let weekDay = date.getWeekDayNumber()
        let dateStart = date.startEndDate().start
        let dateEnd = date.startEndDate().end
        
        let predicateRepeat = NSPredicate(format: "numberOfDay = \(weekDay) AND workoutRepeat = true")
        let predicateUnrepeat = NSPredicate(format: "workoutRepeat = false AND workoutDate BETWEEN %@", [dateStart, dateEnd])
        let compound = NSCompoundPredicate(type: .or , subpredicates: [predicateRepeat, predicateUnrepeat])
        
        let resultArray = RealmManager.shared.getObjectsWorkoutModel()
        let filteredArray = resultArray.filter(compound).sorted(byKeyPath: "workoutName")
        workoutArray = filteredArray.map { $0 }
    }
    
    private func setUpUserparametters() {
        let userArray = RealmManager.shared.getUsersModel()
        if userArray.count != 0 {
            
            userNameLabel.text = userArray[0].userFirstName + " " + userArray[0].userLastName
            guard let data = userArray[0].userImage,
                  let image = UIImage(data: data) else { return }
            
            userPhotoImageView.image = image
        }
    }
    
    private func getWeather() {
        NetworkDataFetch.shared.fetchData(latitude: latitude, longitude: longitude) { [weak self] weatherResult, error in
            guard let self = self else { return }
            if let model = weatherResult {
//                print(model)
                self.weatherView.updateLabels(model: model)
                
                NetworkImageRequest.shared.requestDataForImage(id: model.weather[0].icon) { imageResult in
                    switch imageResult {
                    case .success(let data):
                        self.weatherView.updateImage(data: data)
                    case .failure(let error):
                        print(error.localizedDescription, "imageError")
                    }
                }
                
            }
            if let error = error {
                self.presentSimpleAlert(title: "WARNING\nFailed to get Weather", message: "Weather isn't correct\n*\(error.localizedDescription)")
                self.weatherView.activityIndicator.startAnimating()
                self.weatherView.weatherIcon.isHidden = true
            }
        }
    }
    
    func fetchCityAndCountry(from location: CLLocation, completion: @escaping (_ city: String?, _ country: String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            completion(placemarks?.first?.locality,
                       placemarks?.first?.country,
                       error)
        }
    }
}

//MARK: CLLocationManagerDelegate
extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        latitude = String(location.coordinate.latitude)
        longitude = String(location.coordinate.longitude)
        
        fetchCityAndCountry(from: location) { city, country, error in
            guard let city = city, let country = country, error == nil else { return }
            self.workoutTodayLabel.text = "Workout Today in \(city) \(country)"
        }
        
//        guard let locationForCityCountry: CLLocation = manager.location else { return }
//        fetchCityAndCountry(from: locationForCityCountry) { city, country, error in
//            guard let city = city, let country = country, error == nil else { return }
//            print(city + " " + country)
//            self.workoutTodayLabel.text = "Workout Today in \(city) \(country)"
//        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
        presentSimpleAlert(title: "Error", message: "Failed to access your location!\n\nGo to settings to allow localization for this application")
    }
}

//MARK: CalendarViewProtocol
extension MainViewController: CalendarViewProtocol {
    func selectItem(date: Date) {
        getWorkouts(date: date)
        mainTableView.setWorkoutArray(array: workoutArray )
        mainTableView.reloadData()
        checkWorkoutToday()
    }
}

//MARK: TableViewProtocol
extension MainViewController: MainTableViewProtocol {
    func deleteWorkout(model: WorkoutModel, index: Int) {
        RealmManager.shared.deleteWorkoutModel(model)
        workoutArray.remove(at: index)
        mainTableView.setWorkoutArray(array: workoutArray)
        mainTableView.reloadData()
    }
}

//MARK: WorkoutTableViewCellProtocol
extension MainViewController: WorkoutTableViewCellProtocol {
    func startButtonTapped(model: WorkoutModel) {
        if model.workoutTimer == 0 {
            let reps = RepsWorkoutViewController()
            reps.modalPresentationStyle = .fullScreen
            reps.setWorkoutModel(model)
            present(reps, animated: true)
        } else {
            let timer = TimerWorkoutViewController()
            timer.modalPresentationStyle = .fullScreen
            timer.setWorkoutModel(model)
            present(timer, animated: true)
        }
    }
}
//MARK: - Layouts

typealias MainViewControllerLayouts = MainViewController
extension MainViewControllerLayouts {
    
    private func setUpViews() {
        view.backgroundColor = .specialBackground
        
        view.addSubview(calendarViewGreen)
        calendarViewGreen.setDelegate(self)
        
        view.addSubview(userPhotoImageView)
        view.addSubview(userNameLabel)
        view.addSubview(addWorkOutButton)
        view.addSubview(weatherView)
        view.addSubview(workoutTodayLabel)
        view.addSubview(mainTableView)
        mainTableView.mainDelegate = self
        
        view.addSubview(noWorkoutImageView)
    }
    
    private func setLayouts() {
        setUpUserPhotoImageViewLayouts()
        setUpCalendarViewGreenLayouts()
        setUpUserNameLabeleLayouts()
        setUpAddWorkoutButtonLayouts()
        setUpWeatherViewLayouts()
        setUpWorkoutLabelLayouts()
        setUpMainTableView()
        setUpNoWorkImageView()
    }
    
    private func setUpUserPhotoImageViewLayouts() {
        NSLayoutConstraint.activate([
            userPhotoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            userPhotoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            userPhotoImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25),
            userPhotoImageView.widthAnchor.constraint(equalTo: userPhotoImageView.heightAnchor)
        ])
    }
    
    private func setUpCalendarViewGreenLayouts() {
        NSLayoutConstraint.activate([
            calendarViewGreen.topAnchor.constraint(equalTo: userPhotoImageView.centerYAnchor),
            calendarViewGreen.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            calendarViewGreen.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            //            calendarViewGreen.heightAnchor.constraint(equalToConstant: 70),
            calendarViewGreen.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.17)
        ])
    }
    
    private func setUpUserNameLabeleLayouts() {
        NSLayoutConstraint.activate([
            userNameLabel.bottomAnchor.constraint(equalTo: calendarViewGreen.topAnchor, constant: -10),
            userNameLabel.leadingAnchor.constraint(equalTo: userPhotoImageView.trailingAnchor, constant: 5)
        ])
    }
    
    private func setUpAddWorkoutButtonLayouts() {
        NSLayoutConstraint.activate([
            addWorkOutButton.topAnchor.constraint(equalTo: calendarViewGreen.bottomAnchor, constant: 5),
            addWorkOutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            addWorkOutButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2),
            addWorkOutButton.widthAnchor.constraint(equalTo: addWorkOutButton.heightAnchor)
        ])
    }
    
    private func setUpWeatherViewLayouts() {
        NSLayoutConstraint.activate([
            weatherView.topAnchor.constraint(equalTo: calendarViewGreen.bottomAnchor, constant: 5),
            weatherView.leadingAnchor.constraint(equalTo: addWorkOutButton.trailingAnchor, constant: 10),
            weatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            //            weatherView.heightAnchor.constraint(equalToConstant: 80)
            weatherView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2)
        ])
    }
    
    private func setUpWorkoutLabelLayouts() {
        NSLayoutConstraint.activate([
            workoutTodayLabel.topAnchor.constraint(equalTo: addWorkOutButton.bottomAnchor, constant: 15),
            workoutTodayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            workoutTodayLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
    }
    
    private func setUpMainTableView() {
        NSLayoutConstraint.activate([
            mainTableView.topAnchor.constraint(equalTo: workoutTodayLabel.bottomAnchor, constant: 5),
            mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setUpNoWorkImageView() {
        NSLayoutConstraint.activate([
            noWorkoutImageView.topAnchor.constraint(equalTo: workoutTodayLabel.bottomAnchor, constant: 5),
            noWorkoutImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            noWorkoutImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            noWorkoutImageView.heightAnchor.constraint(equalTo: noWorkoutImageView.widthAnchor, multiplier: 1)
        ])
    }
}

