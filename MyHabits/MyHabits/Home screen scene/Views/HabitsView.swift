//
//  HabitsView.swift
//  MyHabits
//
//  Created by Александр Глазков on 25.02.2021.
//

import UIKit

class HabitsView: UIView {
    
    weak var viewModel: HabitsOutput?
    
    private lazy var collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        var view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = getColorStyle(style: .white)
        view.alwaysBounceVertical = true
        view.dataSource = self
        view.delegate = self
        view.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: ProgressCollectionViewCell.reuseId)
        view.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: HabitCollectionViewCell.reuseId)
        view.toAutoLayout()
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    private func setupLayout() {
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([collectionView.topAnchor.constraint(equalTo: topAnchor),
                                     collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }
}

extension HabitsView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int { 2 }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 1 : HabitsStore.shared.habits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell { viewModel?.onUpdateCell(collectionView,
                                indexPath,
                                indexPath.section == 0 ? ProgressCollectionViewCell.reuseId : HabitCollectionViewCell.reuseId)
                ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (indexPath.section == 1) { viewModel?.onPreview(indexPath) }
    }
}

extension HabitsView: UICollectionViewDelegateFlowLayout {
        
    private func widthForSection(collectionViewWidth: CGFloat,
                                 numberOfItems: CGFloat,
                                 indent: CGFloat) -> CGFloat {
        return (collectionViewWidth - indent * (numberOfItems + 1)) / numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = widthForSection(collectionViewWidth: collectionView.frame.width, numberOfItems: 1, indent: 16)
        return indexPath.section == 0
            ? CGSize(width: width, height: 60)
            : CGSize(width: width, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return section == 0
            ? 18
            : 12
    }
        
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return section == 0
            ? UIEdgeInsets(top: 22, left: 16, bottom: 0, right: 16)
            : UIEdgeInsets(top: 18, left: 16, bottom: 22, right: 16)
    }
}
