//
//  JokeViewController.swift
//  ChuckNorris
//
//  Created by Rodrigo Dumont on 11/12/18.
//  Copyright © 2018 Rodrigo Dumont. All rights reserved.
//

import UIKit

class JokeViewController: UIViewController {

    let viewModel = JokeViewModel()
    let jokeView = JokeView()

    override func loadView() {
        super.loadView()
        self.viewModel.delegate = self
        self.jokeView.delegate = self
        self.view = jokeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getJoke()
    }
}

// MARK: - JokeViewDelegate
extension JokeViewController: JokeViewDelegate {
    func clickOnReloadButton() {
        viewModel.getJoke()
    }
    
    func getCategory() -> String {
        return viewModel.getCategory()
    }
}

// MARK: - JokeViewModelDelegate
extension JokeViewController: JokeViewModelDelegate {
    func show(joke: Joke?) {
        jokeView.show(joke: joke)
    }

    func show(error: Error) {
        jokeView.show(error: error)
    }

    func loadingChanged(isLoading: Bool) {
        isLoading ? jokeView.showLoading() : jokeView.hideLoading()
    }
}
