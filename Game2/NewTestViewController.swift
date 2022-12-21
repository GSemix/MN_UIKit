//
//  NewTestViewController.swift
//  Game2
//
//  Created by Семен Безгин on 19.12.2022.
//

import UIKit

final class NewTestViewController: UIViewController {
    
    private var bottomSheetTransitioningDelegate: UIViewControllerTransitioningDelegate?
    
    let button: UIButton = {
        let view = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        
        view.translatesAutoresizingMaskIntoConstraints = true
        view.backgroundColor = .green
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(button)
        button.addTarget(self, action: #selector(handleShowBottomSheet), for: .touchUpInside)
    }
    
//    @objc private func handleShowBottomSheet() {
//        let viewController = ResizeViewController(initialHeight: 300)
//        // TODO: bottomSheetTransitioningDelegate = ...
//        viewController.modalPresentationStyle = .custom
//        viewController.transitioningDelegate = bottomSheetTransitioningDelegate
//        present(viewController, animated: true, completion: nil)
//    }
    
    @objc private func handleShowBottomSheet() {
        let viewController = ResizeViewController(initialHeight: 300)
        present(viewController, animated: true, completion: nil)
    }
}
