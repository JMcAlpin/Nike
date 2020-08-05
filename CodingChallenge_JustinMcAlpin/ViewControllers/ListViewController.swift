//
//  ListViewController.swift
//  CodingChallenge_JustinMcAlpin
//
//  Created by Admin on 8/4/20.
//

import UIKit

class ListViewController: UIViewController {
    
    let urlString = "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/explicit.json"
    var tableView: UITableView = UITableView()
    var activitySpinner: UIActivityIndicatorView = UIActivityIndicatorView()
    var dataSource: DataModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.downloadJSONFromURL()
        self.setupUserInterface()
    }
    
    func setupUserInterface() {
        self.navigationController?.navigationBar.topItem?.title = "Top 100 Albums"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barTintColor = UIColor.systemGreen
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ListCell.self, forCellReuseIdentifier: "ListCell")
        let tableViewConstraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ]
        NSLayoutConstraint.activate(tableViewConstraints)
        activitySpinner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activitySpinner)
        let activitySpinnerConstraints = [
            activitySpinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activitySpinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ]
        NSLayoutConstraint.activate(activitySpinnerConstraints)
        activitySpinner.startAnimating()
    }
    
    func downloadJSONFromURL() {
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let parsed = try decoder.decode(DataModel.self, from: data)
                        self.dataSource = parsed
                    } catch {
                        let alert = UIAlertController(title: "Download Error!", message: "Could not download list, please close the app and try again later.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                        self.present(alert, animated: true)
                    }
                    DispatchQueue.main.async {
                        self.activitySpinner.stopAnimating()
                        self.tableView.reloadData()
                    }
                }
            }.resume()
        }
    }
    
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.dataSource?.feed.results.count {
            return count
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! ListCell
        let albumName = dataSource?.feed.results[indexPath.row].name
        let artist = dataSource?.feed.results[indexPath.row].artistName
        if let albumArtURL = dataSource?.feed.results[indexPath.row].artworkUrl100 {
            cell.downloadImageFromURL(urlString: albumArtURL)
        }
        cell.albumLabel.text = albumName
        cell.artistLabel.text = artist
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = DetailsViewController()
        let artistName = self.dataSource?.feed.results[indexPath.row].artistName
        let albumName = self.dataSource?.feed.results[indexPath.row].name
        let copyRight = self.dataSource?.feed.results[indexPath.row].copyright
        let genre = self.dataSource?.feed.results[indexPath.row].genres.first?.name
        let releaseDate = self.dataSource?.feed.results[indexPath.row].releaseDate
        let iTunesLink = self.dataSource?.feed.results[indexPath.row].url
        detailsVC.artistLabel.text = artistName
        detailsVC.titleLabel.text = albumName
        detailsVC.copyRightLabel.text = copyRight
        detailsVC.releaseDateLabel.text = "release date: " + (releaseDate ?? "Unknown")
        detailsVC.genreLabel.text = "Genre: " + (genre ?? "Unknown")
        detailsVC.iTunesURL = iTunesLink
        let cell = tableView.cellForRow(at: indexPath) as! ListCell
        detailsVC.artView.image = cell.artView.image
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
}
