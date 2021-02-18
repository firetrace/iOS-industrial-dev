//
//  LoginCheker.swift
//  MyHabits
//
//  Created by Admin on 18.02.2021.
//

import Foundation

struct LoginChecker {
    
    static let shared: LoginChecker = {
        let this = LoginChecker()
        return this
    }()

    private let login: String
    private let password: String
    
    private init() {
        self.login = "user"
        self.password = "password"
    }
    
    func checkLogin(login: String) -> Bool {
        return self.login.uppercased() == login.uppercased()
    }
    
    func checkPassword(password: String) -> Bool {
        return self.password == password
    }
}
