//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Александр Глазков on 14.01.2021.
//

import UIKit
import SnapKit

class HabitViewController: UIViewController {
    
    weak var thisDelegate: HabitDelegate?
    
    private var isNew: Bool { get { habitView.data.isNew } }

    private lazy var habitView: HabitView =  {
        var view = HabitView(frame: .zero)
        view.thisDelegate = self
        view.toAutoLayout()
        
        return view
    }()
    
    convenience init(data: HabitModel) {
        self.init()
        self.habitView.data = data
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        navigationItem.title = isNew ? "Создать" : "Править"
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(save))
        
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(habitView)
        
        habitView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    @objc private func save() {
        if (isNew == false) {
            if let habit = habitView.data.getHabit() {

                habit.name = habitView.data.name
                habit.date = habitView.data.date
                habit.color = habitView.data.color
                
                HabitsStore.shared.save()
            }
        } else { HabitsStore.shared.habits.append(Habit(name: habitView.data.name, date: habitView.data.date, color: habitView.data.color)) }
        
        thisDelegate?.updateData()
        cancel()
    }
    
    @objc private func cancel() {
        dismiss(animated: true, completion: nil)
    }
}

extension HabitViewController: HabitDelegate {
    
    func updateData() {
        thisDelegate?.updateData()
    }
    
    func presentController(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        self.present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
    func dismissController(animated: Bool, completion: (() -> Void)?) {
        self.dismiss(animated: animated, completion: completion)
        thisDelegate?.dismissController(animated: true, completion: nil)
    }
}
