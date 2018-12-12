//
//  JokeViewModel.swift
//  ChuckNorris
//
//  Created by Rodrigo Dumont on 11/12/18.
//  Copyright © 2018 Rodrigo Dumont. All rights reserved.
//

protocol JokeViewModelDelegate {
    func show(joke: Joke?)
    func show(error: Error?)
    func loadingChanged(isLoading: Bool)
}

class JokeViewModel {

    var delegate: JokeViewModelDelegate?

    var isLoading = false {
        didSet {
            delegate?.loadingChanged(isLoading: isLoading)
        }
    }

    func getJoke() {
        isLoading = true
        JokesRepository().getRandom { [weak self] (joke, error) in
            self?.isLoading = false
            self?.delegate?.show(error: error)
            self?.delegate?.show(joke: joke)
        }
    }
}
