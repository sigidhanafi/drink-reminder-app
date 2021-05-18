//
//  ViewController.swift
//  DrinkReminder
//
//  Created by Sigit on 18/05/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var contentView = HomeView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupNavigation()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        title = "Home"
        
        view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    }
    
    private func setupNavigation() {
        // adding add button on the right bar button item
        let addBarButtonItem = UIBarButtonItem(title: "Setting", style: .plain, target: self, action: #selector(navigateToSetting))
        navigationItem.rightBarButtonItem = addBarButtonItem
        
        // set navigation color
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.1921568627, green: 0.2078431373, blue: 0.231372549, alpha: 1)
        navigationController?.navigationBar.shadowImage = UIImage(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.12), size: CGSize(width: 1, height: 0.3))
        
        // set title attribute
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.1921568627, green: 0.2078431373, blue: 0.231372549, alpha: 1).withAlphaComponent(0.96)]
    }
    
    @objc private func navigateToSetting() {
        
    }

}
