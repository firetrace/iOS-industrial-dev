//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Александр Глазков on 18.12.2020.
//

import UIKit

class InfoViewController: UIViewController {

    private lazy var infoView: InfoView =  {
        var view = InfoView(frame: .zero)
        view.toAutoLayout()
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tabBarController?.navigationItem.largeTitleDisplayMode = .never
        
        tabBarController?.navigationItem.title = "Информация"
        tabBarController?.navigationItem.rightBarButtonItem = nil
    }
    
    private func setupLayout() {
        view.addSubview(infoView)
        
        infoView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
