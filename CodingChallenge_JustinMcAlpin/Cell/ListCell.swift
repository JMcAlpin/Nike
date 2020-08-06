//
//  ListCell.swift
//  CodingChallenge_JustinMcAlpin
//
//  Created by Admin on 8/4/20.
//

import UIKit

protocol ListCellDelegate {
    func gotImage(image: UIImage, index: Int)
}

class ListCell: UITableViewCell {

    let artView: UIImageView = UIImageView()
    let albumLabel: UILabel = UILabel()
    let artistLabel: UILabel = UILabel()
    var delegate: ListCellDelegate?
    
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
            artView.centerYAnchor.constraint(equalTo: centerYAnchor),
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
            albumLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -15),
            albumLabel.leftAnchor.constraint(equalTo: artView.rightAnchor, constant: 16),
            albumLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
        ]
        NSLayoutConstraint.activate(albumLabelConstraints)
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        artistLabel.numberOfLines = 3
        let artistLabelConstraints = [
            artistLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 15),
            artistLabel.leftAnchor.constraint(equalTo: artView.rightAnchor, constant: 16),
            albumLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
        ]
        NSLayoutConstraint.activate(artistLabelConstraints)
    }
    
    func downloadImageFromURL(urlString: String) {
        guard let url = URL(string: urlString) else {
            self.showPlaceholderArt()
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, let image = UIImage(data: data) else {
                    self.showPlaceholderArt()
                    return
                }
                self.artView.image = image
                self.delegate?.gotImage(image: image, index: self.tag)
            }
        }.resume()
    }
    
    func showPlaceholderArt() {
        self.artView.image = UIImage(named: "questionMark")
    }
    
}
