//
//  InfoView.swift
//  MyHabits
//
//  Created by Александр Глазков on 14.01.2021.
//

import UIKit
import SnapKit

class InfoView: UIView {

    private let data: InfoModel = InfoModel(title: infoTitle, description: infoDescription)
    
    private lazy var scrollView: UIScrollView = {
        var view = UIScrollView(frame: .zero)
        view.toAutoLayout()
        
        return view
    }()
    
    private lazy var contentView: UIView = {
        var view = UIView(frame: .zero)
        view.toAutoLayout()
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        var title = UILabel(frame: .zero)
        title.text = data.title
        title.font = getFontStyle(style: .title)
        title.toAutoLayout()
        
        return title
    }()
    
    private lazy var textView: UITextView = {
        var view = UITextView(frame: .zero)
        view.isScrollEnabled = false
        view.isEditable = false
        view.text = data.description
        view.font = getFontStyle(style: .body)
        view.toAutoLayout()
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(textView)
        
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(scrollView)
            make.width.equalTo(self).priority(.required)
            make.height.equalTo(self).priority(.low)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(topConst22)
            make.leading.equalTo(contentView).offset(leadingConst16)
            make.trailing.equalTo(contentView).offset(trailingConst16)
        }
        
        textView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(topConst16)
            make.leading.equalTo(contentView).offset(leadingConst16)
            make.trailing.equalTo(contentView).offset(trailingConst16)
            make.bottom.equalTo(contentView).offset(bottomConst16)
        }
    }
}
