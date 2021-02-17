//
//  HabitTableViewCell.swift
//  MyHabits
//
//  Created by Admin on 19.01.2021.
//

import UIKit
import SnapKit

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
        
        dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(topConst16)
            make.leading.equalTo(contentView).offset(leadingConst16)
            make.bottom.equalTo(contentView).offset(bottomConst16)
            make.width.equalTo(contentView).multipliedBy(0.7)
        }
        
        checkImage.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(topConst16)
            make.trailing.equalTo(contentView).offset(trailingConst16)
            make.bottom.equalTo(contentView).offset(bottomConst16)
            make.size.equalTo(20).priority(.low)
        }
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
