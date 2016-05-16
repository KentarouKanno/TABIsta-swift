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
    // メソッドの引数を追加(呼び出し元にクロージャーで戻します)
    static func apiRequest(apiResponse: (responseArticles: [MediaEntity]) -> ()) {
        let articles: [MediaEntity] = []
        apiResponse(responseArticles: articles)
    }
}