//
//  Design.swift
//  MyHabits
//
//  Created by Александр Глазков on 18.12.2020.
//

import UIKit

enum DesignFontStyle {
    case title
    case headline
    case body
    case footnote1
    case footnote2
    case caption
}

enum DesignColorStyle {
    case gray
    case lightGray
    case white
    case magenta
    case blue
    case green
    case darkBlue
    case orange
}

func getFontStyle(style: DesignFontStyle) -> UIFont {

    switch style {
        case .title:
            return UIFont.systemFont(ofSize: 20, weight: .semibold)
        case .headline:
            return UIFont.systemFont(ofSize: 17, weight: .semibold)
        case .body:
            return UIFont.systemFont(ofSize: 17, weight: .regular)
        case .footnote1:
            return UIFont.systemFont(ofSize: 13, weight: .semibold)
        case .footnote2:
            return UIFont.systemFont(ofSize: 13, weight: .regular)
        case .caption:
            return UIFont.systemFont(ofSize: 12, weight: .regular)
    }
}

func getColorStyle(style: DesignColorStyle) -> UIColor {
    switch style {
        case .gray:
            return UIColor.systemGray
        case .lightGray:
            return UIColor.systemGray2
        case .white:
            return getColor(red: 242, green: 242, blue: 247)
        case .magenta:
            return getColor(red: 161, green: 22, blue: 204)
        case .blue:
            return getColor(red: 41, green: 109, blue: 255)
        case .green:
            return getColor(red: 29, green: 179, blue: 34)
        case .darkBlue:
            return getColor(red: 98, green: 54, blue: 255)
        case .orange:
            return getColor(red: 255, green: 159, blue: 79)
    }
}

private func getColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> UIColor {
    let colorMax: CGFloat = 255
    return UIColor.init(red: red/colorMax, green: green/colorMax, blue: blue/colorMax, alpha: alpha)
}
