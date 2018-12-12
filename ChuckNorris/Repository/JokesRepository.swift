//
//  JokesRepository.swift
//  ChuckNorris
//
//  Created by Rodrigo Dumont on 11/12/18.
//  Copyright © 2018 Rodrigo Dumont. All rights reserved.
//

import Foundation

class JokesRepository: BaseRepository {

    init() {
        super.init(path: "jokes")
    }

    func getRandom(then: @escaping Then<Joke>) {
        super.get(url: "\(fullUrl)/random") { (joke, error) in
            then(joke, error)
        }
    }
}
