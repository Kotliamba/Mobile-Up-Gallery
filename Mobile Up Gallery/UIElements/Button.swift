//
//  Button.swift
//  Mobile Up Gallery
//
//  Created by Чаусов Николай on 26.03.2022.
//

import UIKit

class Button: UIButton {

    static func getButton() -> UIButton {
    let button = UIButton()
    button.backgroundColor = .black
    button.setTitle(NSLocalizedString("Button text", comment: ""), for: .normal)
    button.titleLabel?.font = UIFont.SFDisplayMedium(size: 18)
    button.setTitleColor(UIColor.white, for: .normal)
    button.layer.cornerRadius = 8
     
     
     return button
    }
}
