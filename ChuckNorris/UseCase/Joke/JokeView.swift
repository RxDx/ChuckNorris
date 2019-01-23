//
//  JokeView.swift
//  ChuckNorris
//
//  Created by Rodrigo Dumont on 12/12/18.
//  Copyright © 2018 Rodrigo Dumont. All rights reserved.
//

import UIKit

protocol JokeViewDelegate: class {
    func clickOnReloadButton()
}

class JokeView: UIView {

    // MARK: - Properties
    private let jokeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Joke"
        label.numberOfLines = 0
        return label
    }()

    private let loadingView: UIView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.startAnimating()
        view.style = UIActivityIndicatorView.Style.whiteLarge
        view.color = .black
        return view
    }()
    
    private let reloadButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Reload", for: .normal)
        view.setTitleColor(.orange, for: .normal)
        view.isUserInteractionEnabled = true
        return view
    }()

    weak var delegate: JokeViewDelegate?
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        buildView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        buildView()
    }

    // MARK: - Methods
    private func buildView() {
        properties: do {
            backgroundColor = .white
        }
        
        actions: do {
            reloadButton.addTarget(self, action: #selector(clickOnReloadButton), for: .touchUpInside)
        }
        
        hierarchy: do {
            addSubview(jokeLabel)
            addSubview(reloadButton)
        }
        
        constraints: do {
            NSLayoutConstraint.activate([
                jokeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                jokeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                jokeLabel.safeAreaLayoutGuide.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16)])
            
            NSLayoutConstraint.activate([
                reloadButton.topAnchor.constraint(equalTo: jokeLabel.bottomAnchor, constant: 16),
                reloadButton.centerXAnchor.constraint(equalTo: centerXAnchor)])
        }
    }
    
    // MARK: - Actions
    @objc private func clickOnReloadButton() {
        delegate?.clickOnReloadButton()
    }

    // MARK: - Methods
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
    
    func show(joke: Joke?) {
        jokeLabel.text = joke?.value ?? "Loading..."
    }
    
    func show(error: Error) {
        jokeLabel.text = error.localizedDescription
    }
}
