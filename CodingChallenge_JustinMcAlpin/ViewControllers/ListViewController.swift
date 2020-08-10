//
//  ListViewController.swift
//  CodingChallenge_JustinMcAlpin
//
//  Created by Admin on 8/4/20.
//

import UIKit

class ListViewController: UIViewController {
    
    let urlString = "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/explicit.json"
    let tableView: UITableView = UITableView()
    let activitySpinner: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var dataSource: [Album] = []
    var imageCache = [UIImage?](repeating: nil, count: 100)
    let service: NetworkServiceProtocol
    
    init(service: NetworkServiceProtocol = NetworkService()) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
        func downloadFailure() {
            self.showErrorAlert(title: "Download Error!", message: "Could not download list, please close the app and try again later.")
        }
        guard let url = URL(string: urlString) else {
            downloadFailure()
            return
        }
        service.downloadJSON(from: url) { data in
            guard let data = data else {
                downloadFailure()
                return
            }
            let decoder = JSONDecoder()
            do {
                let parsed = try decoder.decode(DataModel.self, from: data)
                self.dataSource = parsed.feed.results
            } catch {
                downloadFailure()
            }
            DispatchQueue.main.async {
                self.activitySpinner.stopAnimating()
                self.tableView.reloadData()
            }
        }
    }
    
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as? ListCell else {
            fatalError("Unable to dequeue \"ListCell\" for tableView")
        }
        let album = self.dataSource[indexPath.row]
        let albumName = album.name
        let artist = album.artistName
        if let image = imageCache[indexPath.row] {
            cell.artView.image = image
        } else {
            if let albumArtURL = album.artworkUrl100 {
                cell.downloadImageFromURL(urlString: albumArtURL)
            } else {
                cell.showPlaceholderArt()
            }
        }
        cell.albumLabel.text = albumName
        cell.artistLabel.text = artist
        cell.delegate = self
        cell.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = DetailsViewController()
        let cell = tableView.cellForRow(at: indexPath) as? ListCell
        let album = self.dataSource[indexPath.row]
        detailsVC.album = album
        detailsVC.albumArt = cell?.artView.image
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
}

extension ListViewController {
    func showErrorAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
}

extension ListViewController: ListCellDelegate {
    func gotImage(image: UIImage, index: Int) {
        imageCache[index] = image
    }
}
