//
//  ServiceError.swift
//  FilckerSearch
//
//  Created by uday on 02/03/2022.
//

import Foundation

enum ServiceError: Error {
    case failedToCreateRequest
    case dataNotFound
    case parsingError
    case networkNotAvailable

}
