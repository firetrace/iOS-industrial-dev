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
    
    var backgroundTask: UIBackgroundTaskIdentifier?
    var backgroundTimeRemaining: TimeInterval? {
        didSet {
            printToLog(" -> \(backgroundTimeRemaining ?? 0)")
        }
    }
    var counterBackgroundTime: String? {
        didSet {
            printToLog(" -> \(counterBackgroundTime ?? "")")
        }
    }
    
    var timer: Timer? {
        didSet {
            if timer != nil {
                timerStart = Date()
            } else {
                timerStart = nil
            }
        }
    }
    var timerStart: Date?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        printToLog()
        
        window = UIWindow(frame: UIScreen.main.bounds)        
        window?.rootViewController = NavigationViewController()
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
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        printToLog()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        printToLog()
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        printToLog()
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        printToLog()
        beginBackgroundTask()
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        printToLog()
        
        return true
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        printToLog()
        
        return true
    }
    
    private func printToLog(_ text: String = "", _ name: String = #function) {
        print("\(Date()): \(name) \(text)")
    }
        
    private func beginBackgroundTask() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] (timer) in
            
            if let start = self?.timerStart {
                let time = timer.fireDate.timeIntervalSince(start)
                
                let hours = Int(time) / 3600
                let minutes = Int(time) / 60 % 60
                let seconds = Int(time) % 60
                
                var times: [String] = []
                if hours > 0 { times.append("\(hours)h") }
                if minutes > 0 { times.append("\(minutes)m") }
                times.append("\(seconds)s")

                self?.backgroundTimeRemaining = UIApplication.shared.backgroundTimeRemaining
                self?.counterBackgroundTime = times.joined(separator: " ")
            }
            
        })
        backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in self?.endBackgroundTask() }
    }
    
    private func endBackgroundTask() {
        guard let task = backgroundTask else {
            return
        }
        
        timer?.invalidate()
        timer = nil
        
        UIApplication.shared.endBackgroundTask(task)
    }
}

