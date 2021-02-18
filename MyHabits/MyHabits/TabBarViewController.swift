//
//  TabBarController.swift
//  MyHabits
//
//  Created by Александр Глазков on 18.12.2020.
//

import UIKit

class TabBarViewController: UITabBarController {

    private let authSystem: AuthSystem = AuthSystem()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    private func setup() {
        let habitsViewController = HabitsViewController(presenter: HabitPresenter())
        habitsViewController.thisAuthDelegate = authSystem
        let infoViewController = InfoViewController()
        
        habitsViewController.tabBarItem = UITabBarItem(title: "Привычки", image: #imageLiteral(resourceName: "habits_tab_icon"), tag: 0)
        infoViewController.tabBarItem = UITabBarItem(title: "Информация", image: UIImage(systemName: "info.circle.fill"), tag: 1)
        
        viewControllers = [habitsViewController, infoViewController]
    }
}
