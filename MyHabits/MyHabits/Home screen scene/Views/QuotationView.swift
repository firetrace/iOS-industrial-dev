//
//  QuotationView.swift
//  MyHabits
//
//  Created by Admin on 02.03.2021.
//

import UIKit

class QuotationView: UIView {
    
    private var tick = 60
    private var tickTimer: Timer?
    
    private lazy var quoteTimer: Timer = {
        var timer = Timer(timeInterval: 60.0, repeats: true, block: { [weak self] (_) in
            
            self?.tick = 60            
            self?.tickTimer?.invalidate()
            self?.tickTimer = nil
                        
            var value = Date().hashValue
            if (value < 0) { value = value * -1 }
            
            if let url = URL(string: "https://api.forismatic.com/api/1.0/?method=getQuote&key=\(value.description.prefix(6))&format=json&lang=ru") {
               URLSession.shared.dataTask(with: url) { data, response, error in
                  if let data = data {
                    let json = JSON(data)
                    DispatchQueue.main.async { [weak self] in
                        self?.quoteLabel.text = json["quoteText"].string ?? "Сдесь могла быть ваша реклама"
                        self?.authorLabel.text = json["quoteAuthor"].string ?? "<без автора>"
 
                        self?.tickTimer = Timer(timeInterval: 1.0, repeats: true, block: { [weak self] (_) in
                            self?.tick -= 1
                            if let tick = self?.tick {
                                self?.tickLabel.text = tick <= 0 ? "обновление ..." : "до обновления \(self?.tick ?? 0) cек ..."
                            } else {
                                self?.tickLabel.text = nil
                            }
                            
                        })
                        
                        if let timer = self?.tickTimer {
                            RunLoop.current.add(timer, forMode: .common)
                            timer.fire()
                        }
                    }
                  }
               }.resume()
            }
        })
        
        return timer
    }()

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
    
    private lazy var tickLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.textAlignment = .center
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
        addSubview(tickLabel)
        
        NSLayoutConstraint.activate([quoteLabel.topAnchor.constraint(equalTo: topAnchor, constant: topConst8),
                                     quoteLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingConst8),
                                     quoteLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: trailingConst8),
                                     authorLabel.topAnchor.constraint(equalTo: quoteLabel.bottomAnchor, constant: topConst4),
                                     authorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingConst8),
                                     authorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: trailingConst8),
                                     tickLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: topConst4),
                                     tickLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingConst8),
                                     tickLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: trailingConst8),
                                     tickLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottomConst8)
        ])
    }
    
    private func start() {
        RunLoop.current.add(quoteTimer, forMode: .common)
        quoteTimer.fire()
    }
}
