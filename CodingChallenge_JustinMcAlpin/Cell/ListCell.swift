//
//  ListCell.swift
//  CodingChallenge_JustinMcAlpin
//
//  Created by Admin on 8/4/20.
//

import UIKit

class ListCell: UITableViewCell {

    let artView: UIImageView = UIImageView()
    let albumLabel: UILabel = UILabel()
    let artistLabel: UILabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        selectionStyle = .none
        addSubview(artView)
        addSubview(albumLabel)
        addSubview(artistLabel)
        artView.layer.cornerRadius = 40
        artView.clipsToBounds = true
        artView.translatesAutoresizingMaskIntoConstraints = false
        let artViewConstraints = [
            artView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            artView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            artView.heightAnchor.constraint(equalToConstant: 80),
            artView.widthAnchor.constraint(equalToConstant: 80)
        ]
        NSLayoutConstraint.activate(artViewConstraints)
        albumLabel.font = UIFont.monospacedSystemFont(ofSize: 20, weight: .bold)
        albumLabel.translatesAutoresizingMaskIntoConstraints = false
        albumLabel.numberOfLines = 2
        albumLabel.adjustsFontSizeToFitWidth = true
        let albumLabelConstraints = [
            albumLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            albumLabel.leftAnchor.constraint(equalTo: artView.rightAnchor, constant: 16),
            albumLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
        ]
        NSLayoutConstraint.activate(albumLabelConstraints)
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        artistLabel.numberOfLines = 3
        let artistLabelConstraints = [
            artistLabel.topAnchor.constraint(equalTo: albumLabel.bottomAnchor, constant: 10),
            artistLabel.leftAnchor.constraint(equalTo: artView.rightAnchor, constant: 16),
            albumLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            artistLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: 10),
        ]
        NSLayoutConstraint.activate(artistLabelConstraints)
    }
    
    func showPlaceholderArt() {
        self.artView.image = UIImage(named: "questionMark")
    }
    
}
