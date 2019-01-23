//
//  JokeViewModel.swift
//  ChuckNorris
//
//  Created by Rodrigo Dumont on 11/12/18.
//  Copyright © 2018 Rodrigo Dumont. All rights reserved.
//

protocol JokeViewModelDelegate: class {
    func show(joke: Joke?)
    func show(error: Error)
    func loadingChanged(isLoading: Bool)
}

class JokeViewModel {

    weak var delegate: JokeViewModelDelegate?

    private var isLoading = false {
        didSet {
            delegate?.loadingChanged(isLoading: isLoading)
        }
    }

    func getJoke() {
        guard !isLoading else {
            return
        }
        
        isLoading = true
        delegate?.show(joke: nil)
        
        JokesRepository().getRandom { [weak self] (joke, error) in
            self?.isLoading = false
            
            self?.delegate?.show(joke: joke)

            if let error = error {
                self?.delegate?.show(error: error)
            }
        }
    }
}
