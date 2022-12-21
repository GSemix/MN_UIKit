//
//  LabelWithParameters.swift
//  Game2
//
//  Created by Семен Безгин on 22.12.2022.
//

import UIKit

final class LabelWithParameters: UILabel {
    var field: String?
    var placeholderForSearchBar: String?
    
    convenience init(field: String, text: String, placeholderForSearchBar: String) {
        self.init()
        self.field = field
        self.placeholderForSearchBar = placeholderForSearchBar
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.numberOfLines = 1
        self.textAlignment = .center
        self.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        self.textColor = .gray
        self.text = text
        self.isUserInteractionEnabled = true
    }
}
