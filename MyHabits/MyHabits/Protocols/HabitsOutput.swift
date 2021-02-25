//
//  HabitsOutputProtocol.swift
//  MyHabits
//
//  Created by Александр Глазков on 25.02.2021.
//

import UIKit

protocol HabitsOutput: AnyObject {
    
    var input: HabitDelegate? { get }
    
    var onAdd: () -> Void { get }
    var onPreview: (IndexPath) -> Void { get }
    var onUpdateCell: (UICollectionView, IndexPath, _ reuseId: String) -> UICollectionViewCell { get }
}
