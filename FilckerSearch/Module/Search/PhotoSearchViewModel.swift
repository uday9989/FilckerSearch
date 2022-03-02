

//
//  PhotoSearchViewModel.swift
//  PhotoSearchGallary
//
//  Created by uday on 02/03/2022.
//

import Foundation
import Combine

class PhotoSearchViewModel: ObservableObject {
    
    let searchRepository:SearchRepositoryType
    private var cancellables:Set<AnyCancellable> = Set()

    @Published var photos:[PhotoDetail] = []
    
    @Published var searchText: String = ""
    
    init(searchRepository:SearchRepositoryType) {
        self.searchRepository = searchRepository
        searchTextListner()
    }
    
    func searchPhotos(apiRequest: ApiRequestType) {
        let publisher =   self.searchRepository.searchPhotos(apiRequest: apiRequest)
        
        let cancalable = publisher
            .sink { completion in
            switch completion {
            case .finished:
                break
            case .failure(_):
                print("Failed")
            }
        } receiveValue: { [weak self ] photosDetail in
             self?.photos = photosDetail
        }
        self.cancellables.insert(cancalable)
    }
    
    func searchTextListner() {
        $searchText.debounce(for: 2, scheduler: RunLoop.main).sink {
            
            let request = ApiRequest(baseUrl: EndPoint.baseUrl, path:Path.search, params:["method":"flickr.photos.search", "text":$0, "api_key": "060c8bb57f264d10dc6463cce0a8f230", "format" : "json", "nojsoncallback" : "1"])
            
            self.searchPhotos(apiRequest: request)
            
        }.store(in: &cancellables)
    }
    
    deinit {
        for cancellable in cancellables {
            cancellable.cancel()
        }
    }
}
