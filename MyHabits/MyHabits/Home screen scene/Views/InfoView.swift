//
//  InfoView.swift
//  MyHabits
//
//  Created by Александр Глазков on 14.01.2021.
//

import UIKit

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
        
        let contentViewWidth = contentView.widthAnchor.constraint(equalTo: widthAnchor)
        contentViewWidth.priority = .required
        let contentViewHeight = contentView.heightAnchor.constraint(equalTo: heightAnchor)
        contentViewHeight.priority = .defaultLow
        
        NSLayoutConstraint.activate([scrollView.topAnchor.constraint(equalTo: topAnchor),
                                     scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
                                     
                                     contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                                     contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                                     contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                                     contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                                     
                                     contentViewWidth,
                                     contentViewHeight,

                                     titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topConst22),
                                     titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: leadingConst16),
                                     titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: trailingConst16),
        
                                     textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: topConst16),
                                     textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: leadingConst16),
                                     textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: trailingConst16),
                                     textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: bottomConst16)])
    }
}
