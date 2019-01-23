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
        self.view = jokeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getJoke()
    }
}

// MARK: - JokeViewModelDelegate
extension JokeViewController: JokeViewModelDelegate {
    func show(joke: Joke?, isLoading: Bool) {
        jokeView.jokeLabel.text = isLoading ? "Loading..." : joke?.value
    }

    func show(error: Error) {
        jokeView.jokeLabel.text = error.localizedDescription
    }

    func loadingChanged(isLoading: Bool) {
        isLoading ? jokeView.showLoading() : jokeView.hideLoading()
    }
}
