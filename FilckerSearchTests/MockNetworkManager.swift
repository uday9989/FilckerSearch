//
//  MockNetworkManager.swift
//  FilckerSearchTests
//
//  Created by uday on 02/03/2022.

import Foundation
@testable import FilckerSearch
import Combine

class MockNetworkManager: Networkable {
    func doApiCall(apiRequest: ApiRequestType) -> Future<Data, ServiceError> {
        return Future { promise in
            
            let bundle = Bundle(for:MockNetworkManager.self)
            
            guard let url = bundle.url(forResource:apiRequest.path, withExtension:"json"),
                  let data = try? Data(contentsOf: url)

            else {
                promise(.failure(ServiceError.dataNotFound))
          
                return
            }
            promise(.success(data))
        }
    }
}

