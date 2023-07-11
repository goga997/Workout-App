//
//  ProfileStatisticCollectionView.swift
//  TrainingApp
//
//  Created by Grigore on 06.07.2023.
//

import UIKit

protocol ProgressViewPRotocol: AnyObject {
    func setProgressView()
}

class ProfileStatisticCollectionView: UICollectionView {
    
    weak var delegateProgress: ProgressViewPRotocol?
    
    private let idProfileCell = "idProfileCell"
    
    private let collectionLayout  = UICollectionViewFlowLayout()
    
    private var resultWorkout = [ResultWorkout]()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: collectionLayout)
        
        configure()
        setUpLayouts()
        setDelegates()
        register(InfoProfileCollViewCell.self, forCellWithReuseIdentifier: idProfileCell)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .none
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setUpLayouts() {
//        collectionLayout.minimumInteritemSpacing = 13
        collectionLayout.scrollDirection = .horizontal
    }
    
    private func setDelegates() {
        dataSource = self
        delegate = self
    }
    
    public func setResultsWorkoutArray(array: [ResultWorkout]) {
        resultWorkout = array
    }
    
    
}

//MARK: - UICollectionViewDataSource

extension ProfileStatisticCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        resultWorkout.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idProfileCell, for: indexPath) as? InfoProfileCollViewCell else { return UICollectionViewCell() }
        
        cell.backgroundColor = (indexPath.row % 4 == 0 || indexPath.row % 4 == 3) ? .specialGreen : .specialDarkYellow
        
        let model = resultWorkout[indexPath.row]
        cell.configure(model: model)
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate

extension ProfileStatisticCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegateProgress?.setProgressView()
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension ProfileStatisticCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2.07,
                      height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
}

