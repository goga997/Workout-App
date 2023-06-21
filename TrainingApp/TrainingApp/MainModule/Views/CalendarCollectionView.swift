//
//  CalendarCollectionView.swift
//  TrainingApp
//
//  Created by Grigore on 08.06.2023.
//

import UIKit

class CalendarCollectionView: UICollectionView {
    
    private let idCalendarCell = "idCalendarCell"
    
    private let collectionLayout  = UICollectionViewFlowLayout()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: collectionLayout)
        
        configure()
        setUpLayouts()
        setDelegates()
        register(CalendarColectionViewCell.self, forCellWithReuseIdentifier: idCalendarCell)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.backgroundColor = .none
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setUpLayouts() {
        collectionLayout.minimumInteritemSpacing = 3
    }
    
    private func setDelegates() {
        dataSource = self
        delegate = self
        
    }
    
}

//MARK: - UICollectionViewDataSource

extension CalendarCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idCalendarCell, for: indexPath) as? CalendarColectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate

extension CalendarCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("tapCollectionCell", indexPath)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension CalendarCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 8,
                      height: collectionView.frame.height)
    }
}
