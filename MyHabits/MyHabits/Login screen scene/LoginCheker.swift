//
//  LoginCheker.swift
//  MyHabits
//
//  Created by Admin on 18.02.2021.
//

import Foundation

struct LoginCheker {
    
    static let shared: LoginCheker = {
        let this = LoginCheker()
        return this
    }()

    private let login: String
    private let password: String
    
    private init() {
        self.login = "user"
        self.password = "password"
    }
    
    func checkLogin(login: String) -> Bool {
        return self.login.uppercased()  == login
    }
    
    func checkPassword(password: String) -> Bool {
        return self.password == password
    }
}
