//
//  MainTabBarController.swift
//  TrainingApp
//
//  Created by Grigore on 15.06.2023.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setItems()
    }
    
    private func setupTabBar() {
        tabBar.backgroundColor = .specialTabBar
        tabBar.tintColor = .specialDarkGreen
        tabBar.unselectedItemTintColor = .specialGray
        tabBar.layer.borderWidth = 2
        tabBar.layer.borderColor = UIColor.specialLightBrown.cgColor
    }
    
    private func setItems() {
        let mainVC = MainViewController()
        let statisticVC = StatisticViewController()
        setViewControllers([mainVC, statisticVC], animated: true)
        
        guard let items = tabBar.items else {return}
        items[0].title = "Main"
        items[1].title = "Statistic"
        items[0].image = UIImage(named: "mainTabBar")
        items[1].image = UIImage(named: "statisticTabBar")
        
        UITabBarItem.appearance().setTitleTextAttributes([.font : UIFont.robotoBold12() as Any], for: .normal)
    }
}
