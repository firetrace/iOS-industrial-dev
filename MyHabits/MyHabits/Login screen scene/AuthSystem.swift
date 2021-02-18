//
//  AuthSystem.swift
//  MyHabits
//
//  Created by Admin on 18.02.2021.
//

import Foundation

class AuthSystem: AuthDelegate {
    
    func checkLogin(_ login: String) -> Bool { LoginCheker.shared.checkLogin(login: login) }
    func checkPassword(_ password: String) -> Bool { LoginCheker.shared.checkPassword(password: password) }
}
