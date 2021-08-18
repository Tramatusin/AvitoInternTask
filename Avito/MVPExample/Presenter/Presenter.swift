//
//  ViewModel.swift
//  MVVMExample
//
//  Created by Виктор Поволоцкий on 07.08.2021.
//

import Foundation
import UIKit

protocol PresenterDelegate: AnyObject{
    var company: SomeCompanyProtocol? { get set }
    
    func setCarthage()
}

protocol PresenterInput : AnyObject{
    func setDataInView(company: SomeCompanyProtocol)
}

class Presenter: PresenterDelegate{
    
    var company: SomeCompanyProtocol?
    
    weak var view: PresenterInput!
    var networkManager: NetworkManager!
    
    func setCarthage() {
        DispatchQueue.global().async {
            self.networkManager.getData {[weak self] result in
                switch result{
                case .success(let company):
                    self?.company = company
                    DispatchQueue.main.async {
                        guard let item = self?.company else {return}
                        self?.view?.setDataInView(company: item)
                    }
                case .failure(let error):
                    switch error {
                    case .badDataError(message: let err):
                        self?.showAlert(message: err)
                    case .badJSONData(message: let err):
                        self?.showAlert(message: err)
                    case .badResponseError(message: let err):
                        self?.showAlert(message: err)
                    }
                }
            }
        }
    }
    
    func showAlert(message: String){
        DispatchQueue.main.async { [weak self] in
            let allert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            allert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            (self?.view as? ViewController)?.present(allert, animated: true, completion: nil)
        }
    }
}
