//
//  NotificationViewController.swift
//  DrinkReminder
//
//  Created by Sigit Hanafi on 02/01/23.
//

import UIKit

class NotificationViewController: UIViewController {
    
    private let viewModel = NotificationViewModel()
    
    private let contentStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let morningStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let morningLabel: UILabel = {
        let label = UILabel()
        label.text = "Morning"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .primaryBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let morningSwitch: UISwitch = {
        let view = UISwitch()
        view.isEnabled = true
        view.tag = NotificationEventType.morning.id
        
        return view
    }()
    
    private let afternoonStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let afternoonLabel: UILabel = {
        let label = UILabel()
        label.text = "Afternoon"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .primaryBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let afternoonSwitch: UISwitch = {
        let view = UISwitch()
        view.isEnabled = true
        view.tag = NotificationEventType.afternoon.id
        
        return view
    }()
    
    private let eveningStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let eveningLabel: UILabel = {
        let label = UILabel()
        label.text = "Evening"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .primaryBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let eveningSwitch: UISwitch = {
        let view = UISwitch()
        view.isEnabled = true
        view.tag = NotificationEventType.evening.id
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Notification"
        
        setupView()
        
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.changeMorningSwitchValue = { [weak self] value in
            self?.morningSwitch.isOn = value
        }
        
        viewModel.changeAfternoonSwitchValue = { [weak self] value in
            self?.afternoonSwitch.isOn = value
        }
        
        viewModel.changeEveningSwitchValue = { [weak self] value in
            self?.eveningSwitch.isOn = value
        }
        
        self.viewModel.didLoadTrigger()
        
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        morningStackView.addArrangedSubview(morningLabel)
        morningStackView.addArrangedSubview(morningSwitch)
        contentStackView.addArrangedSubview(morningStackView)
        
        afternoonStackView.addArrangedSubview(afternoonLabel)
        afternoonStackView.addArrangedSubview(afternoonSwitch)
        contentStackView.addArrangedSubview(afternoonStackView)
        
        
        eveningStackView.addArrangedSubview(eveningLabel)
        eveningStackView.addArrangedSubview(eveningSwitch)
        contentStackView.addArrangedSubview(eveningStackView)
        
        view.addSubview(contentStackView)
        
        morningSwitch.addTarget(self, action: #selector(changeSwitchValueHandler), for: .valueChanged)
        afternoonSwitch.addTarget(self, action: #selector(changeSwitchValueHandler), for: .valueChanged)
        eveningSwitch.addTarget(self, action: #selector(changeSwitchValueHandler), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            contentStackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            contentStackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16)
        ])
    }
    
    @objc private func changeSwitchValueHandler(_ sender: UISwitch) {
        switch sender.tag {
        case NotificationEventType.morning.id:
            viewModel.triggerChangeSwitchValue(type: .morning, currentValue: sender.isOn)
        case NotificationEventType.afternoon.id:
            viewModel.triggerChangeSwitchValue(type: .afternoon, currentValue: sender.isOn)
        case NotificationEventType.evening.id:
            viewModel.triggerChangeSwitchValue(type: .evening, currentValue: sender.isOn)
        default:
            break
        }
    }
}
