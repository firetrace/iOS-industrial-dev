//
//  HabitProtocol.swift
//  MyHabits
//
//  Created by Александр Глазков on 14.01.2021.
//

import UIKit

protocol HabitDelegate: AnyObject {
    
    func updateData()
    func presentController(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)
    func dismissController(animated: Bool, completion: (() -> Void)?)
}
