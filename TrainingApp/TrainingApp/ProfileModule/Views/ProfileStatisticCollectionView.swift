//
//  ProfileStatisticCollectionView.swift
//  TrainingApp
//
//  Created by Grigore on 06.07.2023.
//

import UIKit

class ProfileStatisticCollectionView: UICollectionView {
    
    private let idProfileCell = "idProfileCell"
    
    private let collectionLayout  = UICollectionViewFlowLayout()
    
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
        collectionLayout.minimumInteritemSpacing = 13
        collectionLayout.scrollDirection = .horizontal
    }
    
    private func setDelegates() {
        dataSource = self
        delegate = self
    }
}

//MARK: - UICollectionViewDataSource

extension ProfileStatisticCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idProfileCell, for: indexPath) as? InfoProfileCollViewCell else { return UICollectionViewCell() }
        
        
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate

extension ProfileStatisticCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0 : print("0")
        case 1: print("1")
        case 2: print("2")
        case 3: print("3")
        case 4: print("4")
        default: print("def")
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension ProfileStatisticCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2.1,
                      height: collectionView.frame.width / 2.8)
    }
}

