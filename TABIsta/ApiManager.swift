//
//  ApiManager.swift
//  TABIsta
//
//  Created by System on 2016/05/13.
//  Copyright © 2016年 DIP Corporation. All rights reserved.
//

import Alamofire
import SwiftyJSON

class ApiManager: NSObject {
    static func getLocationMedia(apiResponse: (responseArticles: [[String: String]]) -> ()) {
        let articles: [[String: String]] = []
        apiResponse(responseArticles: articles)
    }
}