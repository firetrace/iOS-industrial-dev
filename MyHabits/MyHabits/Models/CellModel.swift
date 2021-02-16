//
//  File.swift
//  MyHabits
//
//  Created by Admin on 19.01.2021.
//

import UIKit

struct CellModel {

    let date: Date
    let isCheck: Bool
    
    init(date: Date, isCheck: Bool) {
        self.date = date
        self.isCheck = isCheck
    }
}
