//
//  TabBarController.swift
//  MyHabits
//
//  Created by Александр Глазков on 18.12.2020.
//

import UIKit

class TabBarViewController: UITabBarController {

    init(habits: HabitsViewController, info: InfoViewController) {
        super.init(nibName: nil, bundle: nil)
        
        configure(habits: habits, info: info)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(habits: HabitsViewController, info: InfoViewController) {
        habits.tabBarItem = UITabBarItem(title: "Привычки", image: #imageLiteral(resourceName: "habits_tab_icon"), tag: 0)
        info.tabBarItem = UITabBarItem(title: "Информация", image: UIImage(systemName: "info.circle.fill"), tag: 1)
        
        viewControllers = [habits, info]
    }
}
