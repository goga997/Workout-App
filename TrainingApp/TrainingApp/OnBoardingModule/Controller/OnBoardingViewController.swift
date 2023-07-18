//
//  OnBoardingViewController.swift
//  TrainingApp
//
//  Created by Grigore on 18.07.2023.
//

import UIKit

struct OnBoardingStruct {
    let topLabel: String
    let bottomLabel: String
    let image: UIImage
}

class OnBoardingViewController: UIViewController {
    
    private lazy var nextButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .black
        button.layer.cornerRadius = 25
        button.setTitle("NEXT", for: .normal)
        button.titleLabel?.font = .robotoBold20()
//        button.tintColor = .specialGreen
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let pageControl: UIPageControl = {
       let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
        pageControl.isEnabled = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        
        let colllectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        colllectionView.backgroundColor = .white
        colllectionView.isScrollEnabled = false
        colllectionView.showsHorizontalScrollIndicator = false
        colllectionView.translatesAutoresizingMaskIntoConstraints = false
        return colllectionView
    }()
    
    private let idOnBoardingCell = "idOnBoardingCell"
    private var onBoardingArray = [OnBoardingStruct]()
    private var collectionItem = 0
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setConstraints()
        setDelegates()
    }
    
    private func setUpView() {
        view.backgroundColor = .specialGreen
        
        view.addSubview(nextButton)
        view.addSubview(pageControl)
        view.addSubview(collectionView)
        collectionView.register(OnBoardingcollectionViewCell.self, forCellWithReuseIdentifier: idOnBoardingCell)
        
        guard let imageFirst = UIImage(named: "onboardingFirst"),
              let imageSecond = UIImage(named: "onboardingSecond"),
              let imageThird = UIImage(named: "onboardingThird") else { return }
                
        let firstScreen = OnBoardingStruct(topLabel: "Have a good Health",
                                           bottomLabel: "Being healthy is all, no health is nothing. So why do not we",
                                           image: imageFirst)
        let secondScreen = OnBoardingStruct(topLabel: "Be stronger",
                                           bottomLabel: "Take 30 minutes of body building every day to get physically fit and healthy.",
                                           image: imageSecond)
        let thirdScreen = OnBoardingStruct(topLabel: "Have a nice Body",
                                           bottomLabel: "Bad body shape, poor sleep, lack of strength, weight gain, weak bones, easily traumatized body, depressed, stressed, poor metabolism, poor resistance!",
                                           image: imageThird)
        
        onBoardingArray = [firstScreen, secondScreen, thirdScreen]
    }
    
    private func setDelegates() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    @objc private func nextButtonTapped() {
        if collectionItem == 1 {
            nextButton.setTitle("START", for: .normal)
            nextButton.backgroundColor = .white
            nextButton.setTitleColor(.specialGreen, for: .normal)
        }
        
        if collectionItem == 2 {
            saveUserDefaults()
            dismiss(animated: true)
        } else {
            collectionItem += 1
            let index: IndexPath = [0, collectionItem]
            collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = collectionItem
        }
    }
    
    private func saveUserDefaults() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "OnBoardingViewed")
    }
}

//MARK: - UICOLLECTIONVIEW Data Source
extension OnBoardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        onBoardingArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idOnBoardingCell, for: indexPath) as? OnBoardingcollectionViewCell else {return UICollectionViewCell() }
        
        let model = onBoardingArray[indexPath.row]
        cell.cellConfigure(model: model)
        
        return cell
    }
}

//MARK: - UICOLLECTIONVIEW DelegateFLowLAyout
extension OnBoardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width, height: collectionView.frame.height)
    }
}

extension OnBoardingViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            
            pageControl.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -20),
            pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            pageControl.heightAnchor.constraint(equalToConstant: 30),
            
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -20)
        ])
    }
}
