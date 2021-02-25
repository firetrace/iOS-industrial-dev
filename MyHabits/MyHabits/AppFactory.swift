//
//  AppFactory.swift
//  MyHabits
//
//  Created by Александр Глазков on 25.02.2021.
//

import UIKit

final class AppFactory {
    
    private init() {
    }
    
    static let shared: AppFactory = {
        return AppFactory()
    }()
        
    func makeTabBarController(router: Router) -> TabBarViewController {
        let habitsController = makeHabitsController(router: router)
        let infoController = makeInfoController()
        
        return TabBarViewController(habits: habitsController, info: infoController)
    }
    
    func makeHabitsController(router: Router) -> HabitsViewController {
        let habitsViewModel = HabitsViewModel(router: router)
        let habitsViewController = HabitsViewController(viewModel: habitsViewModel)
        habitsViewModel.input = habitsViewController
        
        return habitsViewController
    }
    
    func makeInfoController() -> InfoViewController { InfoViewController() }
    
    func makeHabitController(model: HabitModel) -> HabitViewController { HabitViewController(data: model) }
    
    func makeHabitDetailsController(model: HabitModel) -> HabitDetailsViewController { HabitDetailsViewController(data: model) }
}
