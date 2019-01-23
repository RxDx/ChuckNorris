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
    func getCategory() -> String
}

class JokeView: UIView {

    // MARK: - Properties
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 20, weight: .semibold)
        view.numberOfLines = 0
        return view
    }()
    
    private let jokeLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Joke"
        view.numberOfLines = 0
        return view
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        buildView()
    }

    // MARK: - Private Methods
    private func buildView() {
        properties: do {
            backgroundColor = .white
        }
        
        actions: do {
            reloadButton.addTarget(self, action: #selector(clickOnReloadButton), for: .touchUpInside)
        }
        
        hierarchy: do {
            addSubview(titleLabel)
            addSubview(jokeLabel)
            addSubview(reloadButton)
        }
        
        constraints: do {
            NSLayoutConstraint.activate([
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                titleLabel.safeAreaLayoutGuide.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40)])

            NSLayoutConstraint.activate([
                jokeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                jokeLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
                jokeLabel.safeAreaLayoutGuide.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32)])

            NSLayoutConstraint.activate([
                reloadButton.topAnchor.constraint(equalTo: jokeLabel.bottomAnchor, constant: 40),
                reloadButton.centerXAnchor.constraint(equalTo: centerXAnchor)])
        }
        
        setup: do {
            setupTitle()
        }
    }
    
    private func setupTitle() {
        titleLabel.text = delegate?.getCategory()
    }
    
    // MARK: - Actions
    @objc private func clickOnReloadButton() {
        delegate?.clickOnReloadButton()
    }

    // MARK: - Public Methods
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
