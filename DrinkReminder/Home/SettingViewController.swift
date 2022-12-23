//
//  SettingViewController.swift
//  DrinkReminder
//
//  Created by Sigit Hanafi on 22/12/22.
//

import UIKit

class SettingViewController: UIViewController {
    
    // MARK: properties
    private var targetValue: Double = 0 {
        didSet {
            self.hydrateTargetValueLabel.text = "\(targetValue) liters"
            
            // save to mili liter
            UserDefaults.standard.set(targetValue * 1000, forKey: "hydrateTargetValue")
        }
    }
    
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
            string: "Advice from the International Marathon Medical Directors Association (IMMDA), water consumption of 0.03 liters/kg body weight is said to be sufficient. For example, if we have a weight 50 kg, then the need for water is 0.03 x 50 = 1.5 liters per day.",
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
    
    private let deviderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let hydrateTargetLabel: UILabel = {
        let label = UILabel()
        label.text = "please drink minimum"
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
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        weightFormStackView.addArrangedSubview(weightFormLabel)
        weightFormStackView.addArrangedSubview(weightFormTextField)
        
        contentStackView.addArrangedSubview(infoLabel)
        contentStackView.addArrangedSubview(weightFormStackView)
        contentStackView.addArrangedSubview(deviderView)
        contentStackView.addArrangedSubview(hydrateTargetLabel)
        contentStackView.addArrangedSubview(hydrateTargetValueLabel)
        
        view.addSubview(contentStackView)
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            contentStackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            contentStackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            deviderView.heightAnchor.constraint(equalToConstant: 100),
            deviderView.widthAnchor.constraint(equalTo: contentStackView.widthAnchor),
            hydrateTargetLabel.widthAnchor.constraint(equalTo: contentStackView.widthAnchor),
            hydrateTargetValueLabel.widthAnchor.constraint(equalTo: contentStackView.widthAnchor)
        ])
    }
    
    @objc private func dismissKeyboard() {
        self.view.endEditing(true)
        
        guard let newWeightString = weightFormTextField.text, let newWeightInt = Double(newWeightString) else { return }
        targetValue = newWeightInt * 0.03
    }
}

extension SettingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.dismissKeyboard()
        return false
    }
}
