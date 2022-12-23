//
//  SettingViewController.swift
//  DrinkReminder
//
//  Created by Sigit Hanafi on 22/12/22.
//

import UIKit

class SettingViewController: UIViewController {
    
    // MARK: properties
    
    // MARK: views
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .top
        stackView.spacing = 20
        stackView.backgroundColor = .white
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let infoLabel: UILabel = {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .justified
        
        let attributedString = NSAttributedString(
            string: """
                    We use body weight as a reference for the need for fluids in the body.
                    The first 10 kg of weight, you need 1 liter of water.
                    The second 10 kg, need 500 ml of water.
                    The rest, for every kg of weight, requires 20 ml of water.
                    """,
            attributes: [
                NSAttributedString.Key.paragraphStyle: paragraphStyle
            ])
        
        let label = UILabel()
        label.attributedText = attributedString
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor.black.withAlphaComponent(0.5)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let weightFormStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let weightFormLabel: UILabel = {
        let label = UILabel()
        label.text = "Please fill your weight (kg):"
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor.black.withAlphaComponent(0.5)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let weightFormTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "70"
        field.borderStyle = .roundedRect
        field.textColor = UIColor.black.withAlphaComponent(0.5)
        field.translatesAutoresizingMaskIntoConstraints = false
        field.returnKeyType = .done
        
        return field
    }()
    
    private let deviderHeaderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let deviderBottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let hydrateTargetLabel: UILabel = {
        let label = UILabel()
        label.text = "please drink at least"
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor.blue.withAlphaComponent(0.5)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let hydrateTargetValueLabel: UILabel = {
        let label = UILabel()
        label.text = "- liters"
        label.font = .systemFont(ofSize: 64)
        label.textColor = UIColor.blue.withAlphaComponent(0.5)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let resetValueButton: CustomButton = {
        let button = CustomButton(title: "Reset All Data")
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        weightFormTextField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        setupAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let weight = UserDefaults.standard.integer(forKey: Constant.hydrateWeightValue)
        self.weightFormTextField.text = "\(weight)"
        
        let hydrateTargetValue = UserDefaults.standard.double(forKey: Constant.hydrateTargetValue) // in mili liter
        self.hydrateTargetValueLabel.text = "\(hydrateTargetValue / 1000) liters"
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        weightFormStackView.addArrangedSubview(weightFormLabel)
        weightFormStackView.addArrangedSubview(weightFormTextField)
        
        contentStackView.addArrangedSubview(infoLabel)
        contentStackView.addArrangedSubview(weightFormStackView)
        contentStackView.addArrangedSubview(deviderHeaderView)
        contentStackView.addArrangedSubview(hydrateTargetLabel)
        contentStackView.addArrangedSubview(hydrateTargetValueLabel)
        contentStackView.addArrangedSubview(deviderBottomView)
        contentStackView.addArrangedSubview(resetValueButton)
        
        view.addSubview(contentStackView)
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            contentStackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            contentStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            contentStackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            deviderHeaderView.heightAnchor.constraint(equalToConstant: 70),
            deviderHeaderView.widthAnchor.constraint(equalTo: contentStackView.widthAnchor),
            hydrateTargetLabel.widthAnchor.constraint(equalTo: contentStackView.widthAnchor),
            hydrateTargetValueLabel.widthAnchor.constraint(equalTo: contentStackView.widthAnchor),
            resetValueButton.widthAnchor.constraint(equalTo: contentStackView.widthAnchor)
        ])
    }
    
    private func setupAction() {
        resetValueButton.handler = {
            UserDefaults.resetDefaults()
            
            self.weightFormTextField.text = ""
            self.hydrateTargetValueLabel.text = "- liters"
            self.view.setNeedsLayout()
        }
    }
    
    @objc private func dismissKeyboard() {
        self.view.endEditing(true)
        
        guard let newWeightString = weightFormTextField.text, let newWeightInt = Double(newWeightString) else { return }
        
        var targetValue: Double = 0
        if newWeightInt >= 20 {
            // the first 10kg => 1000 ml
            // the second 10kg => 500 ml
            targetValue += 1500
        }
        
        let restOfWeight = newWeightInt - 20
        if restOfWeight > 0 {
            // the rest kg * 20ml for each kg
            targetValue += restOfWeight * 20
        }
        
        targetValue = ceil(targetValue * 100) / 100
        
        // set hydrate value in mili liter
        UserDefaults.standard.set(targetValue, forKey: Constant.hydrateTargetValue)
        
        // set weight in user default in int
        UserDefaults.standard.set(newWeightInt, forKey: Constant.hydrateWeightValue)
        
        // update the UI
        self.hydrateTargetValueLabel.text = "\(targetValue / 1000) liters"
    }
}

extension SettingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.dismissKeyboard()
        return false
    }
}
