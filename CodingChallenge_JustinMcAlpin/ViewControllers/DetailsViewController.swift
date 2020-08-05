//
//  DetailsViewController.swift
//  CodingChallenge_JustinMcAlpin
//
//  Created by Admin on 8/4/20.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var artView: UIImageView = UIImageView()
    var storeButton: UIButton = UIButton()
    var titleLabel: UILabel = UILabel()
    var artistLabel: UILabel = UILabel()
    var genreLabel: UILabel = UILabel()
    var copyRightLabel: UILabel = UILabel()
    var releaseDateLabel: UILabel = UILabel()
    var iTunesURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.view.backgroundColor = UIColor.systemBackground
        view.addSubview(artView)
        view.addSubview(storeButton)
        view.addSubview(titleLabel)
        view.addSubview(artistLabel)
        view.addSubview(copyRightLabel)
        view.addSubview(genreLabel)
        view.addSubview(releaseDateLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let titleLabelConstraints = [
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            titleLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 24),
            titleLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -24),
            titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8),
        ]
        NSLayoutConstraint.activate(titleLabelConstraints)
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        let artistLabelConstraints = [
            artistLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            artistLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 24),
            artistLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -24),
            artistLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
        ]
        NSLayoutConstraint.activate(artistLabelConstraints)
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        let releaseDateLabelConstraints = [
            releaseDateLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            releaseDateLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 24),
            releaseDateLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -24),
            releaseDateLabel.topAnchor.constraint(equalTo: artView.bottomAnchor, constant: 16),
        ]
        NSLayoutConstraint.activate(releaseDateLabelConstraints)
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        let genreLabelConstraints = [
            genreLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            genreLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 24),
            genreLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -24),
            genreLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 8),
        ]
        NSLayoutConstraint.activate(genreLabelConstraints)
        copyRightLabel.translatesAutoresizingMaskIntoConstraints = false
        let copyRightLabelConstraints = [
            copyRightLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20),
            copyRightLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -24),
            copyRightLabel.bottomAnchor.constraint(equalTo: storeButton.topAnchor, constant: -6),
        ]
        NSLayoutConstraint.activate(copyRightLabelConstraints)
        artView.layer.cornerRadius = 10
        artView.clipsToBounds = true
        artView.translatesAutoresizingMaskIntoConstraints = false
        let artViewConstraints = [
            artView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            artView.heightAnchor.constraint(equalToConstant: 300),
            artView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            artView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            artView.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 16),
        ]
        artView.backgroundColor = UIColor.black
        NSLayoutConstraint.activate(artViewConstraints)
        let storeButtonConstraints = [
            storeButton.heightAnchor.constraint(equalToConstant: 56),
            storeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            storeButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            storeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
        ]
        storeButton.addTarget(self, action: #selector(goToItunesPage), for: .touchUpInside)
        NSLayoutConstraint.activate(storeButtonConstraints)
        self.titleLabel.font = UIFont.monospacedSystemFont(ofSize: 36, weight: .bold)
        self.titleLabel.textAlignment = .center
        self.titleLabel.adjustsFontSizeToFitWidth = true
        self.artistLabel.textAlignment = .center
        self.artistLabel.adjustsFontSizeToFitWidth = true
        self.copyRightLabel.font = UIFont.systemFont(ofSize: 10)
        self.copyRightLabel.textAlignment = .center
        self.copyRightLabel.adjustsFontSizeToFitWidth = true
        self.copyRightLabel.numberOfLines = 1
        self.titleLabel.numberOfLines = 2
        self.copyRightLabel.numberOfLines = 2
        self.artistLabel.numberOfLines = 1
        storeButton.layer.cornerRadius = 10
        storeButton.translatesAutoresizingMaskIntoConstraints = false
        storeButton.backgroundColor = UIColor.systemGreen
            storeButton.setTitle("iTunes", for: .normal)
    }
    
    @objc func goToItunesPage(sender: UIButton) {
        if let iTunesURL = iTunesURL {
            guard let url = URL(string: iTunesURL) else { return }
            UIApplication.shared.open(url)
        }
    }

}
