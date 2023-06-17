//
//  StatisticTableView.swift
//  TrainingApp
//
//  Created by Grigore on 15.06.2023.
//

import UIKit

class StatisticTableView: UITableView {
    
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
    
}

//DATA SOURCE
extension StatisticTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: StatisticCell.idCellStatistics, for: indexPath) as? StatisticCell else { return UITableViewCell() }
        
        return cell
    }
}

//DELEGATES
extension StatisticTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        65
    }
}
