//
//  SettingViewController.swift
//  DrinkReminder
//
//  Created by Sigit Hanafi on 22/12/22.
//

import UIKit

class SettingViewController: UIViewController {
    
    // MARK: properties
    private let dataService = DataServices()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        weightFormTextField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        setupNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let target = self.dataService.getTarget()
        
        self.weightFormTextField.text = "\(target.weight)"
        self.hydrateTargetValueLabel.text = "\(target.target / 1000) liters"
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
        
        view.addSubview(contentStackView)
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            contentStackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            contentStackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            deviderHeaderView.heightAnchor.constraint(equalToConstant: 70),
            deviderHeaderView.widthAnchor.constraint(equalTo: contentStackView.widthAnchor),
            hydrateTargetLabel.widthAnchor.constraint(equalTo: contentStackView.widthAnchor),
            hydrateTargetValueLabel.widthAnchor.constraint(equalTo: contentStackView.widthAnchor)
        ])
    }
    
    private func setupNavigation() {
        // adding add button on the right bar button item
        let addBarButtonItem = UIBarButtonItem(title: "Reset Data", style: .plain, target: self, action: #selector(showConfirmationResetData))
        navigationItem.rightBarButtonItem = addBarButtonItem
    }
    
    @objc private func showConfirmationResetData() {
        let alert = UIAlertController(title: "Reset Data", message: "Are you sure to reset all data?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Reset", style: .default, handler: { [weak self] _ in
            self?.resetData()
        }))
        
        self.present(alert, animated: true)
    }
    
    private func resetData() {
        dataService.reset()
        
        self.weightFormTextField.text = ""
        self.hydrateTargetValueLabel.text = "- liters"
        self.view.setNeedsLayout()
    }
    
    @objc private func dismissKeyboard() {
        self.view.endEditing(true)
        
        guard let newWeightString = weightFormTextField.text, let newWeightInt = Double(newWeightString) else { return }
        
        dataService.saveTarget(weight: newWeightInt)
    
        // update the UI
        let target = dataService.getTarget()
        self.hydrateTargetValueLabel.text = "\(target.target / 1000) liters"
    }
}

extension SettingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.dismissKeyboard()
        return false
    }
}
