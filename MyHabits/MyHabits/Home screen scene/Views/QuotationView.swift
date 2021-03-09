//
//  QuotationView.swift
//  MyHabits
//
//  Created by Admin on 02.03.2021.
//

import UIKit

class QuotationView: UIView {
            
    private lazy var quoteLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.font = getFontStyle(style: .caption)
        label.textColor = getColorStyle(style: .gray)
        label.toAutoLayout()
        
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.textAlignment = .right
        label.font = getFontStyle(style: .caption)
        label.textColor = getColorStyle(style: .gray)
        label.toAutoLayout()
                
        return label
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(displayP3Red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
        setupLayout()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func updateData(quote: String, author: String) {
        quoteLabel.text = quote
        authorLabel.text = author
    }
    
    private func setupLayout() {
        addSubview(quoteLabel)
        addSubview(authorLabel)
        
        NSLayoutConstraint.activate([quoteLabel.topAnchor.constraint(equalTo: topAnchor, constant: topConst8),
                                     quoteLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingConst8),
                                     quoteLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: trailingConst8),
                                     authorLabel.topAnchor.constraint(equalTo: quoteLabel.bottomAnchor, constant: topConst4),
                                     authorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingConst8),
                                     authorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: trailingConst8),
                                     authorLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottomConst8)
        ])
    }
}
