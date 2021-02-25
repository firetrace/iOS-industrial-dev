//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Александр Глазков on 18.12.2020.
//

import UIKit

class HabitsViewController: UIViewController {

    private let viewModel: HabitsOutput
    
    private lazy var addButton: UIBarButtonItem = {
        var button = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(add))
        button.tintColor = getColorStyle(style: .magenta)
        
        return button
    }()
    
    private lazy var habitsView: HabitsView =  {
        var view = HabitsView(frame: .zero)
        view.viewModel = viewModel
        view.toAutoLayout()
        
        return view
    }()
    
    init(viewModel: HabitsOutput) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        setupLayout()
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tabBarController?.navigationItem.largeTitleDisplayMode = .always
        
        tabBarController?.navigationItem.title = "Сегодня"
        tabBarController?.navigationItem.rightBarButtonItem = addButton
    }
    
    private func setupLayout() {
        view.addSubview(habitsView)
        
        NSLayoutConstraint.activate([habitsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     habitsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     habitsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     habitsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }
    
    @objc private func add() { viewModel.onAdd() }
}

extension HabitsViewController: HabitDelegate {

    func updateData() {
        habitsView.reloadData()
    }
    
    func presentController(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        self.present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
    func dismissController(animated: Bool, completion: (() -> Void)?) {
        self.dismiss(animated: animated, completion: completion)
    }
}
