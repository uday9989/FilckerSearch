//
//  UrlImageModel.swift
//  FilckerSearch
//
//  Created by uday on 02/03/2022.
//

import Foundation
import Combine
import UIKit

class UrlImageModel: ObservableObject {
    
    @Published var image: UIImage?
    var imageCache = ImageCache.getImageCache()

    let urlString: String
    
    init(urlString: String) {
        self.urlString = urlString
        loadImage()
    }
    
    func loadImage() {
         if loadImageFromCache() {
             return
         }
         loadImageFromUrl()
     }
     
     func loadImageFromCache() -> Bool {
        
         guard let cacheImage = imageCache.get(forKey: urlString) else {
             return false
         }
         
         image = cacheImage
         return true
     }
    
    func loadImageFromUrl() {
        guard let url =  URL(string: urlString) else {
            return
        }
                let task = URLSession.shared.dataTask(with: url, completionHandler: getImageFromResponse(data:response:error:))
        task.resume()
    }
    
    
    func getImageFromResponse(data: Data?, response: URLResponse?, error: Error?) {
        guard error == nil else {
            print("Error: \(error!)")
            return
        }
        guard let data = data else {
            print("No data found")
            return
        }
        
        DispatchQueue.main.async {
            guard let loadedImage = UIImage(data: data) else {
                return
            }
            
            self.imageCache.set(forKey: self.urlString, image: loadedImage)
            
            self.image = loadedImage
        }
    }
}

