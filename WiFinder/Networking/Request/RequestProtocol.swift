//
//  RequestProtocol.swift
//  WiFinder
//
//  Created by Eduardo Domene Junior on 07/11/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

import Foundation
import Alamofire

protocol RequestProtocol {
    func request(url: String,
                 method: HTTPMethod,
                 params: [String: String]?,
                 headers: HTTPHeaders?,
                 completion: @escaping(DataResponse<Any>) -> Void)
}
