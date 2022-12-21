//
//  ShowRouteViewController.swift
//  Game2
//
//  Created by Семен Безгин on 19.12.2022.
//

import UIKit

final class ShowRouteViewController: UIViewController {
    private let buttonTestView: UIButton = {
        let view = UIButton(type: .system)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        initialize()
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(dismissSelf))
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//
//        if self.isMovingFromParent {
//            navigationController?.isNavigationBarHidden = true
//        }
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.backItem?.title = "Назад"
    }
    
    private func initialize() {
        overrideUserInterfaceStyle = .light
        view.backgroundColor = UIColor(red: 241/255, green: 238/255, blue: 228/255, alpha: 1)
        
        view.addSubview(buttonTestView)
        
        NSLayoutConstraint.activate([
            buttonTestView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonTestView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            buttonTestView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            buttonTestView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2)
        ])
        
        buttonTestView.addTarget(self, action: #selector(test), for: .touchUpInside)
//        navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(dismissSelf))
    }
    
//    @objc private func dismissSelf() {
////        dismiss(animated: true)
//        print("Hello")
//        navigationController?.popToRootViewController(animated: true)
//    }
    
    @objc private func test() {
        let vc = UIViewController()
        vc.view.backgroundColor = .yellow
        navigationController?.overrideUserInterfaceStyle = .light
        navigationController?.pushViewController(vc, animated: true)
    }
}
