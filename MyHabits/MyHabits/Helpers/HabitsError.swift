//
//  HabitsError.swift
//  MyHabits
//
//  Created by Admin on 04.03.2021.
//

import Foundation

enum DataError: LocalizedError {
    case dataNotFound

    var errorDescription: String? {
        get {
            switch self {
            case .dataNotFound:
                 return "Данные не найдены"
            }
        }
    }
}

enum LoadError: LocalizedError {
    case failLoadingData
    case failParseData

    var errorDescription: String? {
        get {
            switch self {
            case .failLoadingData:
                 return "Ошибка загрузки данных"
            case .failParseData:
                return "Ошибка распарсивания данных"
            }
        }
    }
}
