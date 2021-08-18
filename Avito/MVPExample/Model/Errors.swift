//
//  Errors.swift
//  MVPExample
//
//  Created by Виктор Поволоцкий on 18.08.2021.
//

import Foundation

enum UrlDataErrors: Error{
    case badResponseError(message: String)
    case badDataError(message: String)
    case badJSONData(message: String)
}
