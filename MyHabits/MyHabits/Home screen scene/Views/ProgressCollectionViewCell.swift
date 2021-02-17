//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Александр Глазков on 15.01.2021.
//

import UIKit
import SnapKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    private lazy var headerLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.text = progressHeader
        label.font = getFontStyle(style: .body)
        label.textColor = getColorStyle(style: .gray)
        label.toAutoLayout()
        
        return label
    }()
    
    private lazy var progressLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.textAlignment = .right
        label.font = getFontStyle(style: .body)
        label.textColor = getColorStyle(style: .gray)
        label.toAutoLayout()
        
        return label
    }()
    
    private lazy var progressBar: UIProgressView = {
        var view = UIProgressView(frame: .zero)
        view.progressTintColor = getColorStyle(style: .magenta)
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        view.toAutoLayout()
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        layoutUpdate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProgressCollectionViewCell: CellProtocol {
    typealias CellType = Float

    static var reuseId: String { String(describing: self) }
            
    func layoutUpdate() {
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        
        contentView.addSubview(headerLabel)
        contentView.addSubview(progressLabel)
        contentView.addSubview(progressBar)
        
        headerLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(topConst10)
            make.leading.equalTo(contentView).offset(leadingConst12)
            make.width.equalTo(contentView).multipliedBy(0.5)
        }
        
        progressLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(topConst10)
            make.trailing.equalTo(contentView).offset(trailingConst12)
            make.width.equalTo(contentView).multipliedBy(0.3)
        }
        
        progressBar.snp.makeConstraints { (make) in
            make.top.equalTo(headerLabel.snp.bottom).offset(topConst10)
            make.leading.equalTo(contentView).offset(leadingConst12)
            make.trailing.equalTo(contentView).offset(trailingConst12)
            make.bottom.equalTo(contentView).offset(bottomConst15)
        }
    }
    
    func updateCell(object: Float) {
        progressBar.progress = object
        progressLabel.text = String(format: "%.0f %%", object * 100)
    }
}
