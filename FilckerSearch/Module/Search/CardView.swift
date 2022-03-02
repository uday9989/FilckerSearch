//
//  CardView.swift
//  FilckerSearch
//
//  Created by uday on 02/03/2022.
//

import SwiftUI

struct CardView: View {
    let title: String
    let urlStr: String
    
       var body: some View {
           VStack {
               UrlImageView(urlString: urlStr)
               Text(title)
                   .font(.title2)
           }
           
       }
}
