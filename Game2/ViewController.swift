//
//  ViewController.swift
//  Game2
//
//  Created by Семен Безгин on 12.12.2022.
//

import UIKit

final class ViewController: UIViewController {
    private var timer: Timer?
    private var favoriteButtons: [buttonWithParameters] = []
    
    private let screenSize: CGRect = UIScreen.main.bounds
    private lazy var titleTopOffset: CGFloat = screenSize.height * 0.045
    private let cardWidthCoeff: Double = 0.9
    private let cardHeightCoeff: Double = 0.25
    private lazy var cardButtonWidthCoeff: Double = cardWidthCoeff * 0.3 // 0.3 // 0.288
    private lazy var cardButtonHeightCoeff: Double = cardHeightCoeff * 1.05 // 1.05 // 0.265
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        view.contentInsetAdjustmentBehavior = .never
        
        return view
    }()
    private let label: UILabel = {
        let view = UILabel()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        view.text = "Пока здесь ничего нет"
        return view
    }()
    private let button: UIButton = {
        let view = UIButton(type: .system)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.red.cgColor
        view.setTitle("ok", for: .normal)
        view.setTitleColor(.black, for: .normal)
        
        return view
    }()
    private lazy var titleStackView: UIStackView = {
        let view = UIStackView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = 5
        
        return view
    }()
    private lazy var mainIconView: UIImageView = {
        let view = UIImageView()
        let image = UIImage(systemName: "location.viewfinder")?.resized(to: CGSize(width: screenSize.width * 0.11, height: screenSize.width * 0.11 * 7 / 8)) ?? UIImage()
        
        view.image = image
        view.tintColor = .black
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    private lazy var mainLabelView: UILabel = {
        let view = UILabel()
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.2
        view.numberOfLines = 1
        view.text = "Навигация"
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: screenSize.width * 0.095, weight: .bold)
        view.textColor = .black
        
        return view
    }()
    private lazy var headerLabelView: UILabel = {
        let view = UILabel()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Навигация"
        view.textColor = .black
        view.font = UIFont.systemFont(ofSize: screenSize.width * 0.05 , weight: .bold)
        view.textAlignment = .center
        
        return view
    }()
    private lazy var headerView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.opacity = 0
        view.addBlurEffect(.systemMaterialLight)
        
        return view
    }()
    private let mainCardView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 241/255, green: 238/255, blue: 228/255, alpha: 1)
        view.layer.cornerRadius = 25
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 5
        
        return view
    }()
    private lazy var mainSearchButtonView: UIButton = {
        let image = UIImage(systemName: "magnifyingglass")?.resized(to: CGSize(width: screenSize.width * 0.11, height: screenSize.width * 0.11 * 7 / 8))
        let cornerRadius: Double = 25.0
        
        let view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("", for: .normal)
        view.setImage(image, for: .normal)
        view.tintColor = .black
        view.frame.size = CGSize(width: UIScreen.main.bounds.size.width*0.9*0.3, height: UIScreen.main.bounds.size.height*0.25*1.05)

//        view.frame.size = CGSize(width: screenSize.width * cardButtonWidthCoeff, height: screenSize.height * cardButtonHeightCoeff)
        view.backgroundColor = UIColor(red: 241/255, green: 238/255, blue: 228/255, alpha: 1)
        view.layer.cornerRadius = cornerRadius
        view.addGradientCornerBorders(lineWidth: 10, cornerRadius: cornerRadius, colors: [UIColor.blue.cgColor, UIColor.green.cgColor], startPoint: CGPoint.topRight, endPoint: CGPoint.bottomLeft)
        
        return view
    }()
    private let quickSearchTitleStackView: UIStackView = {
        let view = UIStackView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = 5
        
        return view
    }()
    private lazy var quickSearchIconView: UIImageView = {
        let view = UIImageView()
        let image = UIImage(systemName: "clock")?.resized(to: CGSize(width: screenSize.width * 0.065, height: screenSize.width * 0.065 * 7 / 8)) ?? UIImage()
        
        view.image = image
        view.tintColor = .black
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    private lazy var quickSearchLabelView: UILabel = {
        let view = UILabel()
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.2
        view.numberOfLines = 1
        view.text = "Быстрый поиск"
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: screenSize.width * 0.05, weight: .bold)
        view.textColor = .black
        
        return view
    }()
    private let quickSearchScrollView: UIScrollView = {
        let view = UIScrollView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        
        return view
    }()
    private let quickSearchContentView: UIStackView = {
        let view = UIStackView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = 15
        view.alignment = .center
        
        return view
    }()
    private let test1: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        view.layer.cornerRadius = 25
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 5
        
        return view
    }()
    private let test2: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        view.layer.cornerRadius = 25
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 5
        
        return view
    }()
    private let test3: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .yellow
        view.layer.cornerRadius = 25
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 5
        
        return view
    }()
    private let favoritesTitleStackView: UIStackView = {
        let view = UIStackView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = 5
        
        return view
    }()
    private lazy var favoritesIconView: UIImageView = {
        let view = UIImageView()
        let image = UIImage(systemName: "bookmark")?.resized(to: CGSize(width: screenSize.width * 0.065, height: screenSize.width * 0.065 * 7 / 8)) ?? UIImage()
        
        view.image = image
        view.tintColor = .black
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    private lazy var favoritesLabelView: UILabel = {
        let view = UILabel()
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.2
        view.numberOfLines = 1
        view.text = "Избранное"
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: screenSize.width * 0.05, weight: .bold)
        view.textColor = .black
        
        return view
    }()
    
    deinit {
        timer?.invalidate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUsersData()
        initialize()
        setTimer(with: 0.01)
        scrollView.updateVerticalContentView()
        quickSearchScrollView.updateHorizontalContentView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    private func getUsersData() {
        let selectedMaps: [String] = UserDefaults.standard.array(forKey: "selectedMaps") as? [String] ?? [String]()
//        {
//            didSet {
//                UserDefaults.standard.set(selectedMaps, forKey: "selectedMaps")
//            }
//        }
        
        if selectedMaps.count != 0 {
            for x in selectedMaps.indices {
                self.favoriteButtons.append(buttonWithParameters(type: .system, name: selectedMaps[x]))
                self.favoriteButtons[x].addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            }
        }
    }
    
    private func initialize() {
        view.backgroundColor = UIColor(red: 241/255, green: 238/255, blue: 228/255, alpha: 1)
        
        view.addSubview(scrollView)
        view.addSubview(headerView)
        scrollView.addSubview(titleStackView)
        scrollView.addSubview(mainCardView)
        scrollView.addSubview(quickSearchTitleStackView)
        scrollView.addSubview(quickSearchScrollView)
        scrollView.addSubview(favoritesTitleStackView)
        
        if favoriteButtons.count != 0 {
            for x in favoriteButtons.indices {
                scrollView.addSubview(favoriteButtons[x])
            }
        } else {
            scrollView.addSubview(label)
        }

        titleStackView.addArrangedSubview(mainIconView)
        titleStackView.addArrangedSubview(mainLabelView)
        quickSearchScrollView.addSubview(quickSearchContentView)
        quickSearchContentView.addArrangedSubview(test1)
        quickSearchContentView.addArrangedSubview(test2)
        quickSearchContentView.addArrangedSubview(test3)
        quickSearchTitleStackView.addArrangedSubview(quickSearchIconView)
        quickSearchTitleStackView.addArrangedSubview(quickSearchLabelView)
        favoritesTitleStackView.addArrangedSubview(favoritesIconView)
        favoritesTitleStackView.addArrangedSubview(favoritesLabelView)
        headerView.addSubview(headerLabelView)
        mainCardView.addSubview(mainSearchButtonView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            titleStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: titleTopOffset),
            titleStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            mainCardView.topAnchor.constraint(greaterThanOrEqualTo: titleStackView.bottomAnchor, constant: screenSize.height * 0.05),
            mainCardView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            mainCardView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: cardWidthCoeff),
            mainCardView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: cardHeightCoeff),
            
            quickSearchTitleStackView.topAnchor.constraint(equalTo: mainCardView.bottomAnchor, constant: screenSize.height * 0.05),
            quickSearchTitleStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            quickSearchScrollView.topAnchor.constraint(equalTo: quickSearchTitleStackView.bottomAnchor, constant: screenSize.height * 0.02),
            quickSearchScrollView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            quickSearchScrollView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            quickSearchScrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            quickSearchScrollView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: cardHeightCoeff + 0.05),

            quickSearchContentView.leftAnchor.constraint(equalTo: quickSearchScrollView.leftAnchor, constant: 15),
            quickSearchContentView.rightAnchor.constraint(equalTo: quickSearchScrollView.rightAnchor, constant: -15),
            quickSearchContentView.heightAnchor.constraint(equalTo: quickSearchScrollView.heightAnchor),
            quickSearchContentView.centerYAnchor.constraint(equalTo: quickSearchScrollView.centerYAnchor),

            test1.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: cardWidthCoeff),
            test1.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: cardHeightCoeff),

            test2.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: cardWidthCoeff),
            test2.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: cardHeightCoeff),

            test3.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: cardWidthCoeff),
            test3.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: cardHeightCoeff),

            favoritesTitleStackView.topAnchor.constraint(equalTo: quickSearchScrollView.bottomAnchor, constant: screenSize.height * 0.02),
            favoritesTitleStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            headerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            headerLabelView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -10),
            headerLabelView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            mainSearchButtonView.centerYAnchor.constraint(equalTo: mainCardView.centerYAnchor),
            mainSearchButtonView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: cardButtonWidthCoeff),
            mainSearchButtonView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: cardButtonHeightCoeff),
            mainSearchButtonView.rightAnchor.constraint(equalTo: mainCardView.rightAnchor, constant: 10)
        ])
        
        if favoriteButtons.count != 0 {
            for x in favoriteButtons.indices {
                if x == 0 {
                    favoriteButtons[x].topAnchor.constraint(equalTo: favoritesTitleStackView.bottomAnchor, constant: screenSize.height * 0.05).isActive = true
                } else {
                    favoriteButtons[x].topAnchor.constraint(equalTo: favoriteButtons[x - 1].bottomAnchor, constant: screenSize.height * 0.02).isActive = true
                }

                if x == favoriteButtons.count - 1 {
                    favoriteButtons[x].bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -screenSize.height*0.1).isActive = true
                }

                NSLayoutConstraint.activate([
                    favoriteButtons[x].leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
                    favoriteButtons[x].trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16)
                ])
            }
        } else {
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: favoritesTitleStackView.bottomAnchor, constant: screenSize.height * 0.05),
                label.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                label.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                label.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                label.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -screenSize.height*0.1)
            ])
        }
        
//        mainSearchButtonView.addTarget(self, action: #selector(goToShowRouteViewController), for: .touchUpInside)
        mainSearchButtonView.addTarget(self, action: #selector(goToSearchCabinetViewController), for: .touchUpInside)
        
    }
    
    private func setTimer(with interval: Double) {
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] (_) in
            if (self?.scrollView.contentOffset.y)! > (self?.titleTopOffset)! / 2 && self?.headerView.layer.opacity == 0 {
                UIView.transition(with: (self?.headerView)!, duration: 0.15, options: .transitionCrossDissolve, animations: {
                    self?.headerView.layer.opacity = 1
                })
            } else if (self?.scrollView.contentOffset.y)! <= (self?.titleTopOffset)! / 2 && self?.headerView.layer.opacity == 1 {
                UIView.transition(with: (self?.headerView)!, duration: 0.2, options: .transitionCrossDissolve, animations: {
                    self?.headerView.layer.opacity = 0
                })
            }

            if (self?.scrollView.contentOffset.y)! < -(self?.view.safeAreaInsets.top)! {
                let scaleValue: CGFloat = 1 - ((self?.scrollView.contentOffset.y)! + (self?.view.safeAreaInsets.top)!) * 0.005
                UIView.transition(with: (self?.headerView)!, duration: 0.15, options: .transitionCrossDissolve, animations: {
                    self?.titleStackView.transform.a = scaleValue
                    self?.titleStackView.transform.d = scaleValue
                    self?.titleStackView.transform.ty = ((self?.scrollView.contentOffset.y)! + (self?.view.safeAreaInsets.top)!) * 0.5
                })
            }
        }
        
        RunLoop.main.add(timer!, forMode: RunLoop.Mode.common)
    }
    
    @objc private func buttonTapped(_ sender: buttonWithParameters) { // Функция нажатия кнопки
    print(sender.name ?? "Error")
}
    
    @objc private func goToShowRouteViewController() {
//        let rootVC = ShowRouteViewController()
//        let navVC = UINavigationController(rootViewController: rootVC)
//        navVC.modalPresentationStyle = .fullScreen
//        navVC.overrideUserInterfaceStyle = .light
//        present(navVC, animated: true)
        navigationController?.pushViewController(ShowRouteViewController(), animated: true)
//        navigationController?.isNavigationBarHidden = false
    }
    
    @objc private func goToSearchCabinetViewController() {
        let rootVC = SearchingCabinetViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.overrideUserInterfaceStyle = .light
        present(navVC, animated: true)
//        navigationController?.pushViewController(SearchingCabinetViewController(), animated: true)
    }
}

extension CGPoint {
    static let topLeft = CGPoint(x: 0, y: 0)
    static let topCenter = CGPoint(x: 0.5, y: 0)
    static let topRight = CGPoint(x: 1, y: 0)
    static let centerLeft = CGPoint(x: 0, y: 0.5)
    static let center = CGPoint(x: 0.5, y: 0.5)
    static let centerRight = CGPoint(x: 1, y: 0.5)
    static let bottomLeft = CGPoint(x: 0, y: 1.0)
    static let bottomCenter = CGPoint(x: 0.5, y: 1.0)
    static let bottomRight = CGPoint(x: 1, y: 1)
}

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

extension UIScrollView {
    func updateVerticalContentView() {
        self.contentSize.height = self.subviews.sorted(by: { $0.frame.maxY < $1.frame.maxY }).last?.frame.maxY ?? self.contentSize.height
    }
    
    func updateHorizontalContentView() {
        self.contentSize.width = self.subviews.sorted(by: { $0.frame.maxX < $1.frame.maxX }).last?.frame.maxX ?? self.contentSize.width
    }
}

extension UIView {
    static func spacer(size: CGFloat = 10, for layout: NSLayoutConstraint.Axis = .horizontal) -> UIView {
        let spacer = UIView()

        if layout == .horizontal {
            spacer.widthAnchor.constraint(equalToConstant: size).isActive = true
        } else {
            spacer.heightAnchor.constraint(equalToConstant: size).isActive = true
        }
        
        return spacer
    }
    
    func addGradientCornerBorders(lineWidth: CGFloat, cornerRadius: Double, colors: [CGColor], startPoint: CGPoint = CGPoint.topCenter, endPoint: CGPoint = CGPoint.bottomCenter) {
        let gradient = CAGradientLayer()
        gradient.frame.size =  self.frame.size
        gradient.colors = colors
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        
        let shape = CAShapeLayer()
        shape.lineWidth = lineWidth
        shape.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape
        
        self.clipsToBounds = true
        self.layer.addSublayer(gradient)
    }
    
    func addBlurEffect(_ style: UIBlurEffect.Style = .light, cornerRadius: CGFloat = 0) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.layer.cornerRadius = cornerRadius
        blurEffectView.layer.masksToBounds = true
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
}











































//class ViewController: UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        initialize()
//    }
//
//    private func initialize() { // Настрофка интерфейса
//        view.backgroundColor = UIColor(red: 241/255, green: 238/255, blue: 228/255, alpha: 1)
//
//        let label = UILabel()
//        label.text = "🎉 Welcome!"
//        label.font = UIFont.systemFont(ofSize: 20)
//        label.textColor = .black
//        view.addSubview(label)
//
//        label.snp.makeConstraints { make in // Отступы для label
//            make.left.equalToSuperview().inset(50) // Оступ от левого края экрана 50
//            make.top.equalToSuperview().inset(150)
//        }
//
//        let extraLabel = UILabel()
//        extraLabel.text = "Extra Label Extra Label Extra Label Extra Label Extra Label Extra Label Extra Label Extra Label Extra Label Extra Label Extra Label Extra Label Extra Label Extra Label Extra Label Extra Label Extra Label Extra Label Extra Label Extra Label"
//        extraLabel.numberOfLines = 0 // Неограниченное кол-во строк (по умолчанию 1)
//        extraLabel.textColor = .black
//        view.addSubview(extraLabel)
//
//        extraLabel.snp.makeConstraints { make in
//            make.left.right.equalToSuperview().inset(50)
//            make.top.equalTo(label).inset(50) // Оступ сверху от label 30
//        }
//
//        let button = UIButton(type: .system) // Благодаря type: .system кнопка визуально нажимается
//        button.backgroundColor = UIColor(red: 84/255, green: 118/255, blue: 171/255, alpha: 1)
//        button.setTitleColor(.white, for: .normal)
//        button.layer.cornerRadius = 20 // Закругление углов
//        button.setTitle("Get your username ->", for: .normal)
//        view.addSubview(button)
//
//        button.snp.makeConstraints { make in
//            make.centerX.equalToSuperview() // Выравнивание по центру горизонтали
//            make.width.equalTo(250) // Ширина
//            make.height.equalTo(40)
//            make.bottom.equalToSuperview().inset(30)
//        }
//
//        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside) // Привязка кнопки к функции buttonTapped()
//    }
//
//    @objc private func buttonTapped() { // Функция нажатия кнопки
//        print("Get username")
//    }
//}
