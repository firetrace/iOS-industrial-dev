//
//  HabitView.swift
//  MyHabits
//
//  Created by Александр Глазков on 14.01.2021.
//

import UIKit
import SnapKit

class HabitView: UIView {

    weak var thisDelegate: HabitDelegate?
    
    var data: HabitModel = HabitModel()
    {
        didSet {
            nameText.text = data.name
            colorButton.backgroundColor = data.color
            datePicker.date = data.date
            
            updateDateDescription()
            
            if (data.isNew) {
                nameText.becomeFirstResponder()
                delButton.removeFromSuperview()
            }
        }
    }
                
    private lazy var nameLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.text = habitNameTitle
        label.font = getFontStyle(style: .footnote1)
        label.toAutoLayout()
        
        return label
    }()
    
    private lazy var nameText: UITextField = {
        var text = UITextField(frame: .zero)
        text.font = getFontStyle(style: .body)
        text.placeholder = habitNamePlaceholder
        text.addTarget(self, action: #selector(updateName(_:)), for: .editingChanged)
        text.toAutoLayout()
        
        return text
    }()
    
    private lazy var colorLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.text = habitColorTitle
        label.font = getFontStyle(style: .footnote1)
        label.toAutoLayout()
        
        return label
    }()
    
    private lazy var colorButton: UIButton = {
        var button = UIButton(frame: .zero)
        button.addTarget(self, action: #selector(updateColor), for: .touchUpInside)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.toAutoLayout()
        
        return button
    }()
    
    private lazy var dateLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.text = habitDateTitle
        label.font = getFontStyle(style: .footnote1)
        label.toAutoLayout()
        
        return label
    }()
    
    private lazy var dateDescriptionLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.toAutoLayout()
        
        return label
    }()
    
    private lazy var datePicker: UIDatePicker = {
        var picker = UIDatePicker(frame: .zero)
        picker.preferredDatePickerStyle = .wheels
        picker.datePickerMode = .time
        picker.addTarget(self, action: #selector(updateDate(_:)), for: .valueChanged)
        picker.toAutoLayout()
        
        return picker
    }()
    
    private lazy var delButton: UIButton = {
        var button = UIButton(frame: .zero)
        button.addTarget(self, action: #selector(del), for: .touchUpInside)
        button.setTitle("Удалить привычку", for: .normal)
        button.titleLabel?.font = getFontStyle(style: .body)
        button.setTitleColor(.red, for: .normal)
        button.toAutoLayout()
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLayout()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setupLayout() {
        addSubview(nameLabel)
        addSubview(nameText)
        addSubview(colorLabel)
        addSubview(colorButton)
        addSubview(dateLabel)
        addSubview(dateDescriptionLabel)
        addSubview(datePicker)
        addSubview(delButton)
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(topConst22)
            make.leading.equalTo(self).offset(leadingConst16)
            make.trailing.equalTo(self).offset(trailingConst16)
        }
        
        nameText.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(topConst7)
            make.leading.equalTo(self).offset(leadingConst16)
            make.trailing.equalTo(self).offset(trailingConst16)
        }
        
        colorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameText.snp.bottom).offset(topConst15)
            make.leading.equalTo(self).offset(leadingConst16)
            make.trailing.equalTo(self).offset(trailingConst16)
        }
        
        colorButton.snp.makeConstraints { (make) in
            make.top.equalTo(colorLabel.snp.bottom).offset(topConst7)
            make.leading.equalTo(self).offset(leadingConst16)
            make.size.equalTo(30)
        }
        
        dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(colorButton.snp.bottom).offset(topConst15)
            make.leading.equalTo(self).offset(leadingConst16)
            make.trailing.equalTo(self).offset(trailingConst16)
        }
        
        dateDescriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(dateLabel.snp.bottom).offset(topConst7)
            make.leading.equalTo(self).offset(leadingConst16)
            make.trailing.equalTo(self).offset(trailingConst16)
        }
        
        datePicker.snp.makeConstraints { (make) in
            make.top.equalTo(dateDescriptionLabel.snp.bottom).offset(topConst15)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
        }
        
        delButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self).offset(bottomConst8)
        }
    }
    
    @objc private func updateName(_ textField: UITextField) {
        data.name = textField.text ?? ""
    }
    
    @objc private func updateColor() {
        let picker = UIColorPickerViewController()
        picker.selectedColor = data.color
        picker.delegate = self
        
        thisDelegate?.presentController(picker, animated: true, completion: nil)
    }
    
    @objc private func updateDate(_ datePicker: UIDatePicker) {
        if data.date != datePicker.date {
            data.date = datePicker.date
            updateDateDescription()
        }
    }

    @objc private func del() {
        weak var weakSelf = self
        let alert = UIAlertController(title: "Удалить привычку",
                                      message: "Вы хотите удалить привычку \"\(String(describing: data.name))\"?",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: { (action) in
            if let index = weakSelf?.data.id { HabitsStore.shared.habits.remove(at: index) }
            weakSelf?.thisDelegate?.dismissController(animated: true, completion: nil)
        }))
        
        thisDelegate?.presentController(alert, animated: true, completion: nil)
    }
    
    private func updateDateDescription(){
        let baseStr = NSMutableAttributedString(string: habitDateDescriptionPattern,
                                                attributes: [NSAttributedString.Key.font: getFontStyle(style: .body)])
        let formatter = DateFormatter()
        formatter.timeStyle = .short
            
        let dateStr = NSAttributedString(string: formatter.string(from: data.date),
                                         attributes: [NSAttributedString.Key.font: getFontStyle(style: .body),
                                                      NSAttributedString.Key.foregroundColor: getColorStyle(style: .magenta)])
        baseStr.append(dateStr)
        dateDescriptionLabel.attributedText = baseStr
    }
}

extension HabitView: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        if data.color != viewController.selectedColor {
            data.color = viewController.selectedColor
            colorButton.backgroundColor = data.color
        }
    }
}
