//
//  HomeView.swift
//  DrinkReminder
//
//  Created by Sigit on 18/05/21.
//

import Foundation
import UIKit

internal class HomeView: UIView {
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 20
        
        return stackView
    }()
    
    private let dailyContentWrapperStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        
        return stackView
    }()
    
    private let dailyContentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        
        return stackView
    }()
    
    private let dailyStateView: UIView = {
        let view = UIView()
        view.backgroundColor = .cyan
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        return view
    }()
    
    private let dailyPercentageStateView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        return view
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        // add state view
        dailyContentStackView.addArrangedSubview(dailyStateView)
        dailyContentStackView.addArrangedSubview(dailyPercentageStateView)
        
        dailyContentWrapperStackView.addArrangedSubview(dailyContentStackView)
        
        // add button
        drinkButtonContentStackView.addArrangedSubview(buttonDrink1)
        drinkButtonContentStackView.addArrangedSubview(buttonDrink2)
        drinkButtonContentStackView.addArrangedSubview(buttonDrink3)
        drinkButtonContentStackView.addArrangedSubview(buttonDrink4)
        
        drinkButtonContentWrapperStackView.addArrangedSubview(drinkButtonContentStackView)
                
        contentStackView.addArrangedSubview(dailyContentWrapperStackView)
        contentStackView.addArrangedSubview(drinkButtonContentWrapperStackView)
        
        self.addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        contentStackView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor).isActive = true
        contentStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        contentStackView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor).isActive = true
    }
}
