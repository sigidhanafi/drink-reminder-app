//
//  ViewController.swift
//  DrinkReminder
//
//  Created by Sigit on 18/05/21.
//

import UIKit
import UserNotifications

class HomeViewController: UIViewController {
    
    // MARK: properties
    private var progress: CGFloat = 0 {
        didSet {
            self.circularProgressBarView.progressAnimation(fromValue: oldValue, toValue: progress)
        }
    }
    
    private let viewModel = HomeViewModel(dataService: DataServices())
    
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
        stackView.distribution = .fillEqually
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
        bindViewModel()
        
//        UNUserNotificationCenter.current().requestAuthorization(options:[.alert, .badge, .sound]) { success, error in
//            if success {
//                print("Notification set")
//            } else {
//                print(error?.localizedDescription)
//            }
//        }
//        
//        let content = UNMutableNotificationContent()
//        content.title = "Sluuurrp!"
//        content.subtitle = "It's time to hydrate and stay healthy!"
//        content.sound = UNNotificationSound.default
//        
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: false)
//        
//        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//        
//        UNUserNotificationCenter.current().add(request)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        self.viewModel.willAppearTrigger()
    }
    
    private func bindViewModel() {
        viewModel.targetLabel = { [weak self] label in
            self?.circularProgressBarView.targetLayer.string = label
        }
        
        viewModel.progressPercentage = { [weak self] percentage in
            self?.progress = percentage
        }
        
        viewModel.percentageLabel = { [weak self] label in
            self?.circularProgressBarView.percentageLayer.string = label
        }
    }
    
    private func setupView() {
        view.backgroundColor = .white
        title = "Stay Hydrated!"
        
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
            
            self.viewModel.btnDrink1Trigger()
        }
        
        buttonDrink2.handler = { [weak self] in
            guard let self = self else { return }
            
            self.viewModel.btnDrink2Trigger()
        }
        
        buttonDrink3.handler = { [weak self] in
            guard let self = self else { return }
            
            self.viewModel.btnDrink3Trigger()
        }
        
        buttonDrink4.handler = { [weak self] in
            guard let self = self else { return }
            
            self.viewModel.btnDrink4Trigger()
        }
    }
    
    private func setupNavigation() {
        // adding add button on the right bar button item
        let addBarButtonItem = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(navigateToSetting))
        navigationItem.rightBarButtonItem = addBarButtonItem
    }
    
    @objc private func navigateToSetting() {
        let settingViewController = SettingViewController()
        self.navigationController?.pushViewController(settingViewController, animated: true)
    }

}
