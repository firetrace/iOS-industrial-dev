//
//  ViewCellProtocol.swift
//  MyHabits
//
//  Created by Александр Глазков on 15.01.2021.
//

protocol CellProtocol {
    
    associatedtype CellType
    
    static var reuseId: String { get }
    
    func layoutUpdate()
    func updateCell(object: CellType)
}
