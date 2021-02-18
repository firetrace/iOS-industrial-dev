//
//  UpdateProtocol.swift
//  MyHabits
//
//  Created by Admin on 18.02.2021.
//

import UIKit

protocol HabitPresenterProtocol: AnyObject {
    
    var navigation: (() -> UINavigationController?)? { get set }
    func presentHabit(delegate: HabitDelegate)
}
