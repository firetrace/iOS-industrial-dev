//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Александр Глазков on 14.01.2021.
//

import UIKit

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
        
        NSLayoutConstraint.activate([habitView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     habitView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     habitView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     habitView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }

    @objc private func save() {
        if (isNew == false) {
            do {
                let habit = try habitView.data.getHabit()
                
                habit.name = habitView.data.name
                habit.date = habitView.data.date
                habit.color = habitView.data.color
                
                HabitsStore.shared.save()
            } catch DataError.dataNotFound {
                let alert = UIAlertController(title: "Ошибка сохранения",
                                              message: DataError.dataNotFound.errorDescription,
                                              preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: nil))
                    thisDelegate?.presentController(alert, animated: true, completion: nil)
            }
            catch { }   
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
