//
//  CustomGraph.swift
//  DrinkReminder
//
//  Created by Sigit Hanafi on 04/01/23.
//

import UIKit

class CustomGraph: UIView {
    
    private let graphWrapperStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let topMarginView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let statView: UIView = {
        let view = UIView()
        view.backgroundColor = .primaryBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .primaryBlue
        label.text = "-"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    init(frame: CGRect, title: String) {
        super.init(frame: frame)
        
        label.text = title
        
        graphWrapperStackView.addArrangedSubview(topMarginView)
        graphWrapperStackView.addArrangedSubview(statView)
        graphWrapperStackView.addArrangedSubview(label)
        
        self.addSubview(graphWrapperStackView)
        
        NSLayoutConstraint.activate([
            graphWrapperStackView.topAnchor.constraint(equalTo: self.topAnchor),
            graphWrapperStackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            graphWrapperStackView.rightAnchor.constraint(equalTo: self.rightAnchor),
            graphWrapperStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            label.heightAnchor.constraint(equalToConstant: 50),
            statView.heightAnchor.constraint(equalToConstant: frame.height)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
