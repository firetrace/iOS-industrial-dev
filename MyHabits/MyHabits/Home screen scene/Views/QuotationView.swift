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
        start()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    private func start() {
        let timer = Timer(timeInterval: 60.0, target: self, selector: #selector(getQuote), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .common)
        
        timer.fire()
    }
    
    @objc private func getQuote() {
        
        var value = Date().hashValue
        if (value < 0) { value = value * -1 }
        
        if let url = URL(string: "https://api.forismatic.com/api/1.0/?method=getQuote&key=\(value.description.prefix(6))&format=json&lang=ru") {
           URLSession.shared.dataTask(with: url) { data, response, error in
              if let data = data {
                let json = JSON(data)
                DispatchQueue.main.async { [weak self] in
                    self?.quoteLabel.text = json["quoteText"].string ?? "Сдесь могла быть ваша реклама"
                    self?.authorLabel.text = json["quoteAuthor"].string ?? "<без автора>"
                }
              }
           }.resume()
        }
    }

}
