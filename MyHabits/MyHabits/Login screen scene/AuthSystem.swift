//
//  AuthSystem.swift
//  MyHabits
//
//  Created by Admin on 18.02.2021.
//

import Foundation

class AuthSystem: AuthDelegate {
    
    func checkLogin(_ login: String) -> Bool { LoginChecker.shared.checkLogin(login: login) }
    func checkPassword(_ password: String) -> Bool { LoginChecker.shared.checkPassword(password: password) }
}
