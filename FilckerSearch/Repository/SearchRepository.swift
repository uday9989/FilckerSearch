//
//  SearchRepository.swift
//  FilckerSearch
//
//  Created by uday on 02/03/2022.
//

import Foundation
import Combine

protocol SearchRepositoryType {
    func searchPhotos(apiRequest:ApiRequestType)->Future<[PhotoDetail], ServiceError>

}

class SearchRepository: SearchRepositoryType {
   
    let networkManager: Networkable

    var cancellables:Set<AnyCancellable?> = Set()

    init(networkManager:Networkable = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func searchPhotos(apiRequest: ApiRequestType) -> Future<[PhotoDetail], ServiceError> {
        return Future { [unowned self] promise in

                        
            let apiCallPublisher =   self.networkManager.doApiCall(apiRequest: apiRequest)
            
            let cancellable =  apiCallPublisher
                .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    return promise(.failure(error))
                }
                
            } receiveValue: {  data in
                guard let decodedResponse = try? JSONDecoder().decode(SearchResponce.self, from: data) else {
                    return promise(.failure(ServiceError.parsingError))
                }
                
               let phototsDetails = decodedResponse.photos.photo.map {
                   PhotoDetail(id: $0.id, title: $0.title, url: "\(EndPoint.imagesBaseUrl)/\($0.server)/\($0.id)_\($0.secret)_w.jpg")
                }
            
                return promise(.success(phototsDetails))
            }
            
            self.cancellables.insert(cancellable)

        }
    }
    
    deinit {
        cancellables.forEach { cancellable in
            cancellable?.cancel()
        }
    }
}
