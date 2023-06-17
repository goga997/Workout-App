//
//  MainTableView.swift
//  TrainingApp
//
//  Created by Grigore on 14.06.2023.
//

import UIKit

class MainTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        configure()
        setDelegates()
        register(WorkoutTableViewCell.self, forCellReuseIdentifier: WorkoutTableViewCell.idTableViewCell)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.backgroundColor = .none
        self.separatorStyle = .none
        self.bounces = false
        self.showsVerticalScrollIndicator = false
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setDelegates() {
        self.delegate = self
        self.dataSource = self
    }
}

//DATA SOURCE
extension MainTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: WorkoutTableViewCell.idTableViewCell, for: indexPath) as? WorkoutTableViewCell else { return UITableViewCell() }
        
        return cell
    }
}

//DELEGATE
extension MainTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}
