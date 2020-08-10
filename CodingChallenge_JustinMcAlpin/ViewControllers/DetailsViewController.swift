//
//  DetailsViewController.swift
//  CodingChallenge_JustinMcAlpin
//
//  Created by Admin on 8/4/20.
//

import UIKit

class DetailsViewController: UIViewController {
    
    let artView: UIImageView = UIImageView()
    let storeButton: UIButton = UIButton()
    let titleLabel: UILabel = UILabel()
    let artistLabel: UILabel = UILabel()
    let genreLabel: UILabel = UILabel()
    let copyRightLabel: UILabel = UILabel()
    let releaseDateLabel: UILabel = UILabel()
    
    var albumViewModel: AlbumViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        displayAlbumDetails()
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
            artView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 56),
            artView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -56),
            artView.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 16),
            artView.heightAnchor.constraint(equalToConstant: ((self.view.window?.frame.width ?? 300) - 56))
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
        self.titleLabel.numberOfLines = 2
        self.artistLabel.textAlignment = .center
        self.artistLabel.adjustsFontSizeToFitWidth = true
        self.artistLabel.numberOfLines = 1
        self.copyRightLabel.font = UIFont.systemFont(ofSize: 10)
        self.copyRightLabel.textAlignment = .center
        self.copyRightLabel.numberOfLines = 3
        self.releaseDateLabel.textAlignment = .center
        self.genreLabel.textAlignment = .center
        storeButton.layer.cornerRadius = 10
        storeButton.translatesAutoresizingMaskIntoConstraints = false
        storeButton.backgroundColor = UIColor.systemGreen
            storeButton.setTitle("iTunes", for: .normal)
    }
    
    func displayAlbumDetails() {
        guard let album = albumViewModel else { return }
        artistLabel.text = album.artist
        titleLabel.text = album.name
        copyRightLabel.text = album.copyright
        releaseDateLabel.text = album.releaseDate
        genreLabel.text = album.genre
        albumViewModel?.downloadImage({ (albumArt) in
            DispatchQueue.main.async {
                self.artView.image = albumArt
            }
        })
    }
    
    @objc func goToItunesPage(sender: UIButton) {
        if let iTunesURL = albumViewModel?.url, UIApplication.shared.canOpenURL(iTunesURL) {
            UIApplication.shared.open(iTunesURL)
        }
    }

}
