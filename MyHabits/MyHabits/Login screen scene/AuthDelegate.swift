//
//  LoginDelegate.swift
//  MyHabits
//
//  Created by Admin on 18.02.2021.
//

protocol AuthDelegate: AnyObject {
    
    func checkLogin(_ login: String) -> Bool
    func checkPassword(_ password: String) -> Bool
}
