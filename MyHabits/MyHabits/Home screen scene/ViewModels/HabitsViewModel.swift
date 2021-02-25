//
//  HabitsViewModel.swift
//  MyHabits
//
//  Created by Александр Глазков on 25.02.2021.
//

import UIKit

final class HabitsViewModel: HabitsOutput {

    weak var input: HabitDelegate?
    
    private let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    var onAdd: () -> Void {
        return { [weak self] in
            let habitController = AppFactory.shared.makeHabitController(model: HabitModel())
            habitController.thisDelegate = self?.input
            let habitNavigationController = UINavigationController(rootViewController: habitController)
            
            self?.router.presentController(habitNavigationController)
        }
    }
    
    var onPreview: (IndexPath) -> Void {
        return { [weak self] (indexPath) in
            let habit = HabitsStore.shared.habits[indexPath.item]
            let habitDetailController = AppFactory.shared.makeHabitDetailsController(model: HabitModel(id: indexPath.item,
                                                                                                       name: habit.name,
                                                                                                       date: habit.date,
                                                                                                       color: habit.color))
            habitDetailController.thisDelegate = self?.input
            
            self?.router.pushController(habitDetailController)
        }
    }
    
    var onUpdateCell: (UICollectionView, IndexPath, _ reuseId: String) -> UICollectionViewCell {
        return { [weak self] (collectionView, indexPath, reuseId) in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath)
            
            if let editCell = cell as? ProgressCollectionViewCell {
                editCell.updateCell(object: HabitsStore.shared.todayProgress)
            } else if let editCell = cell as? HabitCollectionViewCell {
                editCell.thisDelegate = self?.input
                let habit = HabitsStore.shared.habits[indexPath.item]
                editCell.updateCell(object: HabitModel(id: indexPath.item, name: habit.name, date: habit.date, color: habit.color))
            }
            
            return cell
        }
    }
}
