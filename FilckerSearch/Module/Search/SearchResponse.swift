//
//  SearchResponse.swift
//  FilckerSearch
//
//  Created by uday on 02/03/2022.
//

import Foundation

// MARK: - FlickerSearchResonce
struct SearchResponce: Codable {
    let photos: Photos
    let stat: String
}

// MARK: - Photos
struct Photos: Codable {
    let page, pages, perpage, total: Int
    let photo: [Photo]
}

// MARK: - Photo
struct Photo: Codable {
    let id, owner, secret, server: String
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
}

