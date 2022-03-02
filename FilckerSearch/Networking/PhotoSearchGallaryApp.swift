//
//  PhotoSearchGallaryApp.swift
//  FilckerSearch
//
//  Created by uday on 02/03/2022.
//

import SwiftUI

@main
struct PhotoSearchGallaryApp: App {
    var body: some Scene {
        WindowGroup {
            PhotoSearchView(searchViewModel:PhotoSearchViewModel(searchRepository: SearchRepository()))
                .padding()
        }
    }
}
