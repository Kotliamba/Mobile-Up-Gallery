//
//  Label.swift
//  Mobile Up Gallery
//
//  Created by Чаусов Николай on 26.03.2022.
//

import UIKit

class Label: UILabel {

    static func getFistScreenLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .black
        label.font = UIFont.labelFont(size: 48)
        label.numberOfLines = 1
        return label
    }

}
