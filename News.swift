//
//  News.swift
//  globalstart
//
//  Created by Buty on 7/23/18.
//  Copyright © 2018 globalstart. All rights reserved.
//

import Foundation

struct News: Decodable {
    let news: NewsJson
}

struct NewsJson: Decodable {
    let data: [DataJson]
}

struct DataJson: Decodable {
    let id: Int
    let title: String
    let image: String
    let description: String
    let created_at: String
}
