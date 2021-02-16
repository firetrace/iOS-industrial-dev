//
//  HabitTableViewCell.swift
//  MyHabits
//
//  Created by Admin on 19.01.2021.
//

import UIKit

class HabitTableViewCell: UITableViewCell {
    
    private lazy var dateLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.font = getFontStyle(style: .body)
        label.toAutoLayout()
        
        return label
    }()
    
    private lazy var checkImage: UIImageView = {
        var image = UIImageView()
        image.tintColor = getColorStyle(style: .magenta)
        image.contentMode = .scaleAspectFit
        image.toAutoLayout()
        
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutUpdate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutUpdate() {
        
        contentView.addSubview(dateLabel)
        contentView.addSubview(checkImage)
        
        let checkImageWidth = checkImage.widthAnchor.constraint(lessThanOrEqualToConstant: 20)
        checkImageWidth.priority = .defaultLow
        let checkImageHeight = checkImage.heightAnchor.constraint(lessThanOrEqualToConstant: 20)
        checkImageHeight.priority = .defaultLow
        
        NSLayoutConstraint.activate([dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topConst16),
                                     dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: leadingConst16),
                                     dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: bottomConst16),
                                     dateLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7),
                                     
                                     checkImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topConst16),
                                     checkImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: trailingConst16),
                                     checkImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: bottomConst16),
                                     checkImageHeight,
                                     checkImageWidth])
    }
}

extension HabitTableViewCell: CellProtocol {
    typealias CellType = CellModel
    
    static var reuseId: String { String(describing: self) }
    
    func updateCell(object: CellModel) {
        var dateStr: String?
        if (Calendar.current.isDateInToday(object.date)) { dateStr = "Сегодня" }
        else if (Calendar.current.isDateInYesterday(object.date)) { dateStr = "Вчера" }
        else {
            let currentDateComponents = Calendar.current.dateComponents([.day, .month, .year], from: Date())
            let inDateComponents = Calendar.current.dateComponents([.day, .month, .year], from: object.date)
                
            if (currentDateComponents.year == inDateComponents.year &&
                currentDateComponents.month == inDateComponents.month &&
                (currentDateComponents.day ?? 0) - (inDateComponents.day ?? 0) == 2) { dateStr = "Позавчера" }
            else {
                if let indexDate = HabitsStore.shared.dates.lastIndex(of: object.date) {
                    dateStr = HabitsStore.shared.trackDateString(forIndex: indexDate)
                }
            }
        }
        
        dateLabel.text = dateStr
        if (object.isCheck) {
            checkImage.image = UIImage(systemName: "checkmark")
        }
    }
}
