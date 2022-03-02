//
//  PhotoSearchView.swift
//  FilckerSearch
//
//  Created by uday on 02/03/2022

import SwiftUI

struct PhotoSearchView: View {
    
    @ObservedObject var searchViewModel:PhotoSearchViewModel
    
    var columns: [GridItem] = [
            GridItem(.flexible()),
            GridItem(.flexible()),
        ]
    let height: CGFloat = 150
    @State private var searchText = ""

    var body: some View {
        ScrollView {
            TextField("Type your search",text: $searchViewModel.searchText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                  LazyVGrid(columns: columns, spacing: 16) {
                      ForEach(searchViewModel.photos) { card in
                          CardView(title: card.title, urlStr: card.url)
                              .frame(height: height)
                      }
                  }
                  .padding()
        }
    }
}
