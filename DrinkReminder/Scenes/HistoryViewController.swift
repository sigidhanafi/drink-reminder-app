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
    private var progressData = [ProgressData]()
    
    // MARK: views
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        bindViewModel()
        
        self.tableView.dataSource = self

        self.viewModel.didloadTrigger()
    }
    
    private func bindViewModel() {
        self.viewModel.progressData = { [weak self] data in
            self?.progressData = data
            self?.tableView.reloadData()
        }
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        title = "History"
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
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
        return progressData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier")
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "cellIdentifier")
        }
        
        cell?.textLabel?.text = "\(progressData[indexPath.row].progress) mililiters"
        
        let date = progressData[indexPath.row].date
        let dateformate = DateFormatter()
        dateformate.dateFormat = "dd-MM-yyyy HH:mm"
        let dateFormated = dateformate.string(from: date)
        
        cell?.detailTextLabel?.text = "\(dateFormated)"
        
        return cell ?? UITableViewCell()
    }
}
