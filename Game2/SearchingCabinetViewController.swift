//
//  SearchingCabinetViewController.swift
//  Game2
//
//  Created by Семен Безгин on 20.12.2022.
//

import UIKit

protocol NextViewControllerDelegate {
    func callback(_ cab: String, with field: String)
}

class SearchingCabinetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    var barHeight: CGFloat {
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            return window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            return UIApplication.shared.statusBarFrame.height
        }
    }
    private let myArray: [String] = ["First11","Second","Third", "First","Second","Third","First","Second","Third", "First","Second","Third","First","Second","Third", "First","Second","Third","First","Second","Third", "First","Second","Third","First","Second","Third", "First","Second","Third"]
    var searchdata: [String] = []
    private var myTableView: UITableView!
    lazy var searchBar: UISearchBar = UISearchBar()
    var delegate: NextViewControllerDelegate?
    var field: String?
    var placeholder: String?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        overrideUserInterfaceStyle = .light
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: self.view.window)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: self.view.window)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        
        myTableView = UITableView()
        myTableView.frame.size = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - barHeight)
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.contentInset.bottom = barHeight
        self.view.addSubview(myTableView)

        searchBar.searchBarStyle = .default
        searchBar.placeholder = placeholder ?? " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.delegate = self
        searchBar.backgroundColor = .purple
        searchBar.searchTextField.textColor = .black
        searchBar.searchTextField.backgroundColor = .white
        navigationItem.titleView = searchBar

        searchdata = myArray
    }

    @objc func keyboardWillShow(_ notification:Notification) {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                myTableView.contentInset.bottom = keyboardSize.height + barHeight
            }
    }

    @objc func keyboardWillHide(_ notification:Notification) {
        myTableView.contentInset.bottom = barHeight
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        searchdata = textSearched.isEmpty ? myArray : myArray.filter { (item: String) -> Bool in
            return item.range(of: textSearched, options: .caseInsensitive, range: nil, locale: nil) != nil
        }

        myTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(searchdata[indexPath.row])")
        
        delegate?.callback(searchdata[indexPath.row], with: field ?? "")
        dismiss(animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchdata.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.textLabel!.text = "\(searchdata[indexPath.row])"
        return cell
    }
}
