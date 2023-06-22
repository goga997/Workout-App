//
//  CalendarCollectionView.swift
//  TrainingApp
//
//  Created by Grigore on 08.06.2023.
//

import UIKit

protocol CalendarViewProtocol: AnyObject {
    func selectItem(date: Date)
}

class CalendarCollectionView: UICollectionView {
    weak var calendarDelegate: CalendarViewProtocol?
    
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
        
        let dateTimeZone = Date()
        let weekArray = dateTimeZone.getWeekArray()
        
        cell.setDateForCell(numberOfDay: weekArray[1][indexPath.row], dayOfWeek: weekArray[0][indexPath.row])
        
        if indexPath.item == 6 {
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .right)
        }
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate

extension CalendarCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dateTimeZone = Date()
        let date = dateTimeZone.offsetDays(day: 6 - indexPath.item)
        calendarDelegate?.selectItem(date: date)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension CalendarCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 8,
                      height: collectionView.frame.height)
    }
}
