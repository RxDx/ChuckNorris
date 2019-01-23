//
//  JokeView.swift
//  ChuckNorris
//
//  Created by Rodrigo Dumont on 12/12/18.
//  Copyright © 2018 Rodrigo Dumont. All rights reserved.
//

import UIKit

class JokeView: UIView {

    let jokeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Joke"
        label.numberOfLines = 0
        return label
    }()

    let loadingView: UIView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.startAnimating()
        view.style = UIActivityIndicatorView.Style.whiteLarge
        view.color = .black
        return view
    }()

    init() {
        super.init(frame: .zero)
        buildView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        buildView()
    }

    func buildView() {
        properties: do {
            backgroundColor = .white
        }
        
        hierarchy: do {
            addSubview(jokeLabel)
        }
        
        constraints: do {
            NSLayoutConstraint.activate([
                jokeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                jokeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                jokeLabel.safeAreaLayoutGuide.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16)])
        }
    }

    func showLoading() {
        if loadingView.superview == nil {
            addSubview(loadingView)
            loadingView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            loadingView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        }
    }

    func hideLoading() {
        if loadingView.superview != nil {
            loadingView.removeFromSuperview()
        }
    }
    
}
