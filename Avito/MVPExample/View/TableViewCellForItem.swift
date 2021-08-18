//
//  TableViewCellForItem.swift
//  MVVMExample
//
//  Created by Виктор Поволоцкий on 07.08.2021.
//

import UIKit

class TableViewCellForItem: UITableViewCell {
    
    static let tableViewCellId = "cellID"
    
    lazy var viewForItems: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var labelForNameEmployee: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    lazy var labelForPhoneNumber: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var labelForSkills: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()

//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
    
    func configureCell(name: String, phone: String, skills: [String]){
        labelForNameEmployee.text = "Имя работника: \(name)"
        labelForPhoneNumber.text = "Номер телефона: \(phone)"
        labelForSkills.text = "Скилы работника: \(skills.joined(separator: ", "))"
    }

    func setupConstraint(){
        addSubview(viewForItems)
        viewForItems.addSubview(labelForNameEmployee)
        viewForItems.addSubview(labelForPhoneNumber)
        viewForItems.addSubview(labelForSkills)
        
        NSLayoutConstraint.activate([
            viewForItems.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            viewForItems.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            viewForItems.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            viewForItems.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            
            labelForNameEmployee.leftAnchor.constraint(equalTo: viewForItems.leftAnchor, constant: 8),
            labelForNameEmployee.topAnchor.constraint(equalTo: viewForItems.topAnchor, constant: 4),
            labelForNameEmployee.rightAnchor.constraint(lessThanOrEqualTo: viewForItems.rightAnchor, constant: -8),
            
            labelForPhoneNumber.topAnchor.constraint(greaterThanOrEqualTo: labelForNameEmployee.bottomAnchor, constant: 4),
            labelForPhoneNumber.leftAnchor.constraint(equalTo: labelForNameEmployee.leftAnchor),
            labelForPhoneNumber.rightAnchor.constraint(equalTo: labelForNameEmployee.rightAnchor),

            labelForSkills.leftAnchor.constraint(equalTo: labelForNameEmployee.leftAnchor),
            labelForSkills.rightAnchor.constraint(equalTo: labelForNameEmployee.rightAnchor),
            labelForSkills.topAnchor.constraint(equalTo: labelForPhoneNumber.bottomAnchor, constant: 4),
            labelForSkills.bottomAnchor.constraint(equalTo: viewForItems.bottomAnchor, constant: -4)
        ])
    }
    
    func configureCell(){
        viewForItems.layer.cornerRadius = 20
        viewForItems.clipsToBounds = false
        viewForItems.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        viewForItems.layer.shadowOpacity = 1
        viewForItems.layer.shadowRadius = 7
        viewForItems.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .white
        self.selectionStyle = .none
        setupConstraint()
        configureCell()
    }
}
