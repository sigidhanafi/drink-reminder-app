//
//  ViewController.swift
//  DrinkReminder
//
//  Created by Sigit on 18/05/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: properties
    private var progress: CGFloat = 0
    
    // MARK: views
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 20
        
        return stackView
    }()
    
    private let mainContentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        
        return stackView
    }()
    
    private let drinkButtonContentWrapperStackView: UIStackView  = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        
        return stackView
    }()
    
    private let drinkButtonContentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 10
        
        return stackView
    }()
    
    private let buttonDrink1: CustomButton = {
        let button = CustomButton(title: "small \n cup")
        
        return button
    }()
    
    private let buttonDrink2: CustomButton = {
        let button = CustomButton(title: "medium \n cup")
        
        return button
    }()
    
    private let buttonDrink3: CustomButton = {
        let button = CustomButton(title: "small \n bottle")
        
        return button
    }()
    
    private let buttonDrink4: CustomButton = {
        let button = CustomButton(title: "medium \n bottle")
        
        return button
    }()
    
    let circularProgressBarView = CircularProgressBarView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupNavigation()
        setupAction()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        title = "Drink Reminder"
        
        mainContentStackView.addArrangedSubview(circularProgressBarView)
        mainContentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // add button
        drinkButtonContentStackView.addArrangedSubview(buttonDrink1)
        drinkButtonContentStackView.addArrangedSubview(buttonDrink2)
        drinkButtonContentStackView.addArrangedSubview(buttonDrink3)
        drinkButtonContentStackView.addArrangedSubview(buttonDrink4)
        
        drinkButtonContentWrapperStackView.addArrangedSubview(drinkButtonContentStackView)
                
        contentStackView.addArrangedSubview(mainContentStackView)
        contentStackView.addArrangedSubview(drinkButtonContentWrapperStackView)
        
        view.addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        contentStackView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
        contentStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        contentStackView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
    }
    
    private func setupAction() {
        buttonDrink1.handler = { [weak self] in
            guard let self = self else { return }
            let currentProgress = self.progress
            self.progress += 0.1
            self.circularProgressBarView.progressAnimation(fromValue: currentProgress, toValue: self.progress)
        }
        
        buttonDrink2.handler = { [weak self] in
            guard let self = self else { return }
            let currentProgress = self.progress
            self.progress += 0.2
            self.circularProgressBarView.progressAnimation(fromValue: currentProgress, toValue: self.progress)
        }
        
        buttonDrink3.handler = { [weak self] in
            guard let self = self else { return }
            let currentProgress = self.progress
            self.progress += 0.25
            self.circularProgressBarView.progressAnimation(fromValue: currentProgress, toValue: self.progress)
        }
        
        buttonDrink4.handler = { [weak self] in
            guard let self = self else { return }
            let currentProgress = self.progress
            self.progress += 0.4
            self.circularProgressBarView.progressAnimation(fromValue: currentProgress, toValue: self.progress)
        }
    }
    
    private func setupNavigation() {
        // adding add button on the right bar button item
        let addBarButtonItem = UIBarButtonItem(title: "Setting", style: .plain, target: self, action: #selector(navigateToSetting))
        navigationItem.rightBarButtonItem = addBarButtonItem
    }
    
    @objc private func navigateToSetting() {
        let settingViewController = SettingViewController()
        self.navigationController?.pushViewController(settingViewController, animated: true)
    }

}
