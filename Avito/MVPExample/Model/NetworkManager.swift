//
//  NetworkManager.swift
//  MVVMExample
//
//  Created by Виктор Поволоцкий on 06.08.2021.
//

import Foundation
import SwiftyJSON

protocol NetworkManager {
    func getData(completion: @escaping (Result<SomeCompanyProtocol?,UrlDataErrors>)->())
}

class NetworkManagerImplementation: NetworkManager{
    
    private let urlString: String = "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"
    
    func getData(completion:@escaping (Result<SomeCompanyProtocol?,UrlDataErrors>)->()){
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
            guard let resp = response as? HTTPURLResponse, resp.statusCode != 400, resp.statusCode != 401
            else {
                completion(.failure(.badResponseError(message: "Bad HTTPResponse code")))
                return
            }
            
            guard let data = data else {
                completion(.failure(.badDataError(message: "Warning get data")))
                return
            }
            
            guard let json = try? JSON(data: data) else {
                completion(.failure(.badJSONData(message: "Bad json data")))
                return
            }
            
            let company = self?.parseJSON(json: json)
            
            completion(.success(company))
        }.resume()
        
    }
    
    private func parseJSON(json: JSON)-> Company?{
        guard let compnanyName = json["company"]["name"].string else {
            return nil
        }
        let employeesObject: [Employee?] = json["company"]["employees"].arrayValue.map(
            {item in
                let name = item["name"].string
                let phone = item["phone_number"].string
                let skills = item["skills"].arrayValue.map({$0.stringValue})
                return Employee(name: name, pNumber: phone, skills: skills)})
        let sortEmployee = employeesObject.sorted(by:{ item1,item2 in
            guard let emp = item1?.name, let emp2 = item2?.name else { return false}
            return emp < emp2
        })
        
        return Company(name: compnanyName, employees: sortEmployee)
    }
}
