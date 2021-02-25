//
//  RouterProtocol.swift
//  MyHabits
//
//  Created by Александр Глазков on 25.02.2021.
//
import UIKit

protocol Router {
    
    func presentController(_: UIViewController)
    func pushController(_: UIViewController)
}
