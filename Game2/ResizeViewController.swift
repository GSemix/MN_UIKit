//
//  ResizeViewController.swift
//  Game2
//
//  Created by Семен Безгин on 19.12.2022.
//

import UIKit
import SnapKit

final class ResizeViewController: UIViewController {
    // MARK: - Subviews
    
    private let contentSizeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    var isShowNextButtonHidden: Bool {
        navigationController == nil
    }
    
    var isShowRootButtonHidden: Bool {
        navigationController?.viewControllers.count ?? 0 <= 1
    }
    
    private let showNextButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Show next", for: .normal)
        return button
    }()
    
    private let showRootButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemPink
        button.setTitle("Show root", for: .normal)
        return button
    }()
    
    private let _scrollView = UIScrollView()
    
    // MARK: - Private properties
    private lazy var actions = [
        ButtonAction(title: "x2", backgroundColor: .systemBlue, handler: { [unowned self] in
            updateContentHeight(newValue: currentHeight * 2)
        }),
        ButtonAction(title: "/2", backgroundColor: .systemBlue, handler: { [unowned self] in
            updateContentHeight(newValue: currentHeight / 2)
        }),
        ButtonAction(title: "+100", backgroundColor: .systemBlue, handler: { [unowned self] in
            updateContentHeight(newValue: currentHeight + 100)
        }),
        ButtonAction(title: "-100", backgroundColor: .systemBlue, handler: { [unowned self] in
            updateContentHeight(newValue: currentHeight - 100)
        }),
    ]
    
    private var currentHeight: CGFloat {
        didSet {
            updatePreferredContentSize()
        }
    }
    
    // MARK: - Init
    init(initialHeight: CGFloat) {
        currentHeight = initialHeight
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewCoontroller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        updatePreferredContentSize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.setNeedsLayout()
    }
    
    // MARK: - Setup
    
    private func setupSubviews() {
        view.backgroundColor = .white
        
        view.addSubview(_scrollView)
        _scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        _scrollView.alwaysBounceVertical = true
        
        _scrollView.addSubview(contentSizeLabel)
        contentSizeLabel.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
        }
        
        let buttons = actions.map(UIButton.init(buttonAction:))
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.distribution = .fillEqually
        stackView.spacing = 8

        _scrollView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalTo(contentSizeLabel.snp.bottom).offset(8)
            $0.width.equalToSuperview().offset(-32)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
        
        if !isShowNextButtonHidden {
            _scrollView.addSubview(showNextButton)
            showNextButton.addTarget(self, action: #selector(handleShowNext), for: .touchUpInside)
            showNextButton.snp.makeConstraints {
                $0.top.equalTo(stackView.snp.bottom).offset(8)
                $0.centerX.equalTo(stackView)
                $0.width.equalTo(300)
                $0.height.equalTo(50)
            }
        }
        
        if !isShowRootButtonHidden {
            _scrollView.addSubview(showRootButton)
            showRootButton.addTarget(self, action: #selector(handleShowRoot), for: .touchUpInside)
            showRootButton.snp.makeConstraints {
                $0.top.equalTo(isShowNextButtonHidden ? stackView.snp.bottom : showNextButton.snp.bottom).offset(8)
                $0.centerX.equalTo(stackView)
                $0.width.equalTo(300)
                $0.height.equalTo(50)
            }
        }
    }
    
    // MARK: - Private methods
    
    private func updatePreferredContentSize() {
        _scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: currentHeight)
        contentSizeLabel.text = "preferredContentHeight = \(currentHeight)"
        preferredContentSize = _scrollView.contentSize
    }
    
    private func updateContentHeight(newValue: CGFloat) {
        guard newValue >= 200 && newValue < 5000 else { return }

        let updates = { [self] in
            currentHeight = newValue
            updatePreferredContentSize()
        }

        if navigationController == nil {
            UIView.animate(withDuration: 0.25, animations: updates)
        } else {
            updates()
        }
    }
    
    @objc
    private func handleShowNext() {
        let viewController = ResizeViewController(initialHeight: currentHeight)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc
    private func handleShowRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
    
}








struct ButtonAction {
    let title: String
    let backgroundColor: UIColor
    let handler: () -> Void
}


extension UIButton {
    private final class ButtonAdapter {
        private let handler: () -> Void
        let controlEvent: UIControl.Event

        init(handler: @escaping () -> Void, controlEvent: UIControl.Event) {
            self.handler = handler
            self.controlEvent = controlEvent
        }
        
        @objc
        func handle() {
            handler()
        }
    }

    static private var key: UInt8 = 0

    private var adapters: [ButtonAdapter] {
        get {
            objc_getAssociatedObject(self, &Self.key) as? [ButtonAdapter] ?? []
        }
        set {
            objc_setAssociatedObject(self, &Self.key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    convenience init(buttonAction: ButtonAction) {
        self.init(frame: .zero)

        backgroundColor = buttonAction.backgroundColor
        setTitle(buttonAction.title, for: .normal)
        addEventHandler(handler: buttonAction.handler, controlEvent: .touchUpInside)
    }
    
    func addEventHandler(handler: @escaping () -> Void, controlEvent: UIControl.Event) {
        let adapter = ButtonAdapter(handler: handler, controlEvent: controlEvent)
        addTarget(adapter, action: #selector(ButtonAdapter.handle), for: controlEvent)
        adapters.append(adapter)
    }
}
