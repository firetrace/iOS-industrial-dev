//
//  AppDelegate.swift
//  MyHabits
//
//  Created by Александр Глазков on 18.12.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let coordinator = AppCoordinator()
        
        window = UIWindow(frame: UIScreen.main.bounds)        
        window?.rootViewController = coordinator.navigator
        window?.makeKeyAndVisible()
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(displayP3Red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]

        let color = getColorStyle(style: .magenta)
        
        UINavigationBar.appearance().tintColor = color
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().prefersLargeTitles = true
        
        UITabBar.appearance().tintColor = color
        
        return true
    }
}

