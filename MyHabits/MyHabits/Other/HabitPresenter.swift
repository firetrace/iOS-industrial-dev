//
//  HabitPresenter.swift
//  MyHabits
//
//  Created by Admin on 18.02.2021.
//

import UIKit

class HabitPresenter: HabitPresenterProtocol {
    var navigation: (() -> UINavigationController?)?
        
    func presentHabit(delegate: HabitDelegate) {
        guard let thisNavigation = navigation else { return }
        
        let habitViewController = HabitViewController(data: HabitModel())
        habitViewController.thisDelegate = delegate
        thisNavigation()?.present(UINavigationController(rootViewController: habitViewController), animated: true, completion: nil)
    }
}
