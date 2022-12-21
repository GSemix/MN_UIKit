//
//  ButtonWithParameters.swift
//  Game2
//
//  Created by Семен Безгин on 19.12.2022.
//

import UIKit

final class buttonWithParameters: UIButton {
    var name: String?
    
    convenience init(type: UIButton.ButtonType, name: String) {
        self.init(type: type)
        self.name = name
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle(self.name, for: .normal)
        self.setTitleColor(.black, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        self.contentEdgeInsets = UIEdgeInsets(top: UIScreen.main.bounds.size.height*0.01,
                                              left: .leastNormalMagnitude,
                                              bottom: UIScreen.main.bounds.size.height*0.01,
                                              right: .leastNormalMagnitude)
        self.backgroundColor = UIColor(red: 241/255, green: 238/255, blue: 228/255, alpha: 1)
        self.layer.cornerRadius = 15
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 5
    }
}
