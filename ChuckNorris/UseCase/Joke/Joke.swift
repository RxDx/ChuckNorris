//
//  Joke.swift
//  ChuckNorris
//
//  Created by Rodrigo Dumont on 11/12/18.
//  Copyright © 2018 Rodrigo Dumont. All rights reserved.
//

struct Joke: Codable {

    var iconUrl: String?
    var id: String?
    var url: String?
    var value: String?
    var category: String?

    enum CodingKeys: String, CodingKey {
        case iconUrl = "icon_url"
        case id, url, value, category
    }
}
