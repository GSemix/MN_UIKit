//
//  SearchingCabinetViewController.swift
//  Game2
//
//  Created by Семен Безгин on 20.12.2022.
//

import UIKit
class SearchingCabinetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
    private let myArray: [String] = ["First11","Second","Third", "First","Second","Third","First","Second","Third", "First","Second","Third","First","Second","Third", "First","Second","Third","First","Second","Third", "First","Second","Third","First","Second","Third", "First","Second","Third"]
    var searchdata: [String]!
    private var myTableView: UITableView!
    lazy var searchBar: UISearchBar = UISearchBar()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        view.backgroundColor = .white
        
        myTableView = UITableView()
        myTableView.frame.size = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - barHeight)
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        self.view.addSubview(myTableView)
        
        searchBar.searchBarStyle = .default
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        searchdata = myArray
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                myTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            }
    }

    @objc func keyboardWillHide(_ notification:Notification) {
        myTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
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
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.textLabel!.text = "\(searchdata[indexPath.row]) 1"
        return cell
    }
}
