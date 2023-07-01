//
//  StatisticTableView.swift
//  TrainingApp
//
//  Created by Grigore on 15.06.2023.
//

import UIKit

class StatisticTableView: UITableView {
    
    private var differenceArray = [DifferenceWorkout]()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        configureView()
        setDelegates()
        register(StatisticCell.self, forCellReuseIdentifier: StatisticCell.idCellStatistics)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        self.backgroundColor = .none
        self.separatorStyle = .none
        self.showsVerticalScrollIndicator = false
        self.translatesAutoresizingMaskIntoConstraints = false
    }
   
    private func setDelegates() {
        self.dataSource = self
        self.delegate = self
    }
    
    public func setDifferenceArray(array: [DifferenceWorkout]) {
        differenceArray = array
    }
    
}

//DATA SOURCE
extension StatisticTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        differenceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: StatisticCell.idCellStatistics, for: indexPath) as? StatisticCell else { return UITableViewCell() }
        
        let currentElement = differenceArray[indexPath.row]
        cell.configure(differenceWorkout: currentElement)
        return cell
    }
}

//DELEGATES
extension StatisticTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        65
    }
}
