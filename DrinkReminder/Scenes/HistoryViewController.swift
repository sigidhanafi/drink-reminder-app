//
//  HistoryViewController.swift
//  DrinkReminder
//
//  Created by Sigit Hanafi on 26/12/22.
//

import UIKit

class HistoryViewController: UIViewController {
    
    // MARK: properties
    private let viewModel = HistoryViewModel(dataService: DataServices())
    private var progressStat = [ProgressStat]()
    
    // MARK: views
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private let statStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        bindViewModel()
        
        self.tableView.dataSource = self

        self.viewModel.didloadTrigger()
    }
    
    private func bindViewModel() {
        self.viewModel.progressStat = { [weak self] data in
            // update tableview
            self?.progressStat = data
            self?.tableView.reloadData()
            
            // the biggest achievement in ml, will be used as a 100% standard
            guard let maxValue = data.map({ $0.value }).max() else { return }
            
            
            // update view stat / grapth
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                let parentHeight = self?.statStackView.frame.height ?? 0
                let parentWidth = self?.statStackView.frame.width ?? 0
                for d in data {
                    let percentageValue = ((d.value / maxValue) * 100) / 100
                    
                    // calculate frame and height
                    let graphFrame = CGRect(x: 0, y: 0, width: parentWidth / 7, height: floor(percentageValue * (parentHeight - 50)))
                    
                    let statDay11 = CustomGraph(frame: graphFrame, title: d.key)
                    self?.statStackView.addArrangedSubview(statDay11)
                }
            })
        }
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        title = "Progress"
    
        view.addSubview(statStackView)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            statStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            statStackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            statStackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            statStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -20),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor)
        ])
    }
}

extension HistoryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return progressStat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier")
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "cellIdentifier")
        }
        
        cell?.textLabel?.text = "\(progressStat[indexPath.row].value) mililiters"
        cell?.detailTextLabel?.text = progressStat[indexPath.row].key
        
        return cell ?? UITableViewCell()
    }
}
