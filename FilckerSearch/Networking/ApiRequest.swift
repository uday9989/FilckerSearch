//
//  ApiRequest.swift
//  FilckerSearch
//
//  Created by uday on 02/03/2022.
//

import Foundation

protocol ApiRequestType {
    var baseUrl:String {get}
    var path:String {get}
    var params:[String:String] {get}
}

struct ApiRequest:ApiRequestType {
    var baseUrl: String
    var path: String
    var params: [String : String]
}

