//
//  TestViewController.swift
//  Game2
//
//  Created by Семен Безгин on 15.12.2022.
//

import UIKit

class TestViewController: UIViewController {
    private let testView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame.size = CGSize(width: 200, height: 200)
        
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.green.cgColor, UIColor.yellow.cgColor]
        gradient.locations = [0, 1]
        gradient.frame = view.bounds
        view.layer.addSublayer(gradient)
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        initialize()
//        let horizontalScrollView = UIScrollView(frame: CGRectMake(40.0, 40.0, 300.0, 300.0))
//        horizontalScrollView.backgroundColor = UIColor.gray
//        horizontalScrollView.contentSize = CGSizeMake(2000.0, 300.0)
//        self.view.addSubview(horizontalScrollView)
//
//        let verticalScrollView = UIScrollView(frame: CGRectMake(40.0, 40.0, 220.0, 220.0))
//        verticalScrollView.backgroundColor = UIColor.green
//        verticalScrollView.contentSize = CGSizeMake(220.0, 2000.0)
//        horizontalScrollView.addSubview(verticalScrollView)
        
    }
    
    private func initialize() {
//        view.addSubview(testView)
//        
//        NSLayoutConstraint.activate([
//            testView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
//            testView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
//            testView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
//            testView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
//        ])
        
        
        let lineWidth: CGFloat = 30
        let cornerRadius: Double = 15.0
        
        let button = UIButton()
        
        button.frame.size = CGSize(width: 300, height: 300)
        button.backgroundColor = .red
        button.layer.cornerRadius = cornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: .zero, size: button.frame.size)
        gradient.colors = [UIColor.blue.cgColor, UIColor.green.cgColor]
        let shape = CAShapeLayer()
        shape.lineWidth = lineWidth
        shape.path = UIBezierPath(roundedRect: button.bounds, cornerRadius: cornerRadius).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape
        
//        let gradient1 = CAGradientLayer()
//        gradient1.frame =  CGRect(origin: .zero, size: button.frame.size)
//        gradient1.colors = [UIColor.blue.cgColor, UIColor.blue.cgColor]
//        let shape1 = CAShapeLayer()
//        shape1.lineWidth = lineWidth
//        shape1.path = UIBezierPath(roundedRect: button.bounds.insetBy(dx: lineWidth, dy: lineWidth), cornerRadius: cornerRadius).cgPath
//        gradient1.mask = shape1
        
//        button.layer.addSublayer(gradient1)
        button.layer.addSublayer(gradient)
        
        view.addSubview(button)
    }
}
