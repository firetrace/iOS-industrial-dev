//
//  AppCoordinator.swift
//  MyHabits
//
//  Created by Александр Глазков on 25.02.2021.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    private(set) lazy var navigator: UINavigationController = {
        return UINavigationController(rootViewController: AppFactory.shared.makeTabBarController(router: self))
    }()
}

extension AppCoordinator: Router {
    
    func presentController(_ controller: UIViewController) {
        navigator.present(controller, animated: true, completion: nil)
    }
    
    func pushController(_ controller: UIViewController) {
        navigator.pushViewController(controller, animated: true)
    }
}
