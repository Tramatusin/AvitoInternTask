//  ViewController.swift
//  MVVMExample
//
//  Created by Виктор Поволоцкий on 06.08.2021.


import UIKit
//presenterinput
class ViewController: UIViewController, PresenterInput{
    
    func setDataInView(company: SomeCompanyProtocol) {
        DispatchQueue.main.async { [weak self] in
            self?.company = company
            self?.tableForItems.reloadData()
            self?.navigationItem.title = company.companyName
        }
    }
    
    var company: SomeCompanyProtocol?
    var presenter: PresenterDelegate!
    
    lazy var tableForItems: UITableView = {
        let table = UITableView(frame: .zero)
        table.register(TableViewCellForItem.self, forCellReuseIdentifier: TableViewCellForItem.tableViewCellId)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.backgroundColor = .white
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraint()
        presenter?.setCarthage()
    }

    func setupConstraint(){
        view.addSubview(tableForItems)
        
        NSLayoutConstraint.activate([
            tableForItems.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableForItems.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableForItems.topAnchor.constraint(equalTo: view.topAnchor),
            tableForItems.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return company?.employees.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellForItem.tableViewCellId, for: indexPath) as! TableViewCellForItem
        guard let name = company?.employees[indexPath.row]?.name,
              let phone = company?.employees[indexPath.row]?.phoneNumber,
              let skills = company?.employees[indexPath.row]?.skills else {
            return cell
        }
        cell.configureCell(name: name, phone: phone, skills: skills)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

