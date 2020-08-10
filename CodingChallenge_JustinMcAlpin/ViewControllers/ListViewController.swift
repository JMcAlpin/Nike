//
//  ListViewController.swift
//  CodingChallenge_JustinMcAlpin
//
//  Created by Admin on 8/4/20.
//

import UIKit

class ListViewController: UIViewController {
    
    let tableView: UITableView = UITableView()
    let activitySpinner: UIActivityIndicatorView = UIActivityIndicatorView()
    
    let viewModel: AlbumListViewModel
    
    init(service: NetworkServiceProtocol = NetworkService()) {
        viewModel = AlbumListViewModel(service: service)
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
        let success: () -> Void = {
            DispatchQueue.main.async {
                self.activitySpinner.stopAnimating()
                self.tableView.reloadData()
            }
        }
        let failure: () -> Void = {
            self.showErrorAlert(title: "Download Error!", message: "Could not download list, please close the app and try again later.")
        }
        viewModel.downloadAlbums(success, failure)
    }
    
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.viewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as? ListCell else {
            fatalError("Unable to dequeue \"ListCell\" for tableView")
        }
        let album = self.viewModel.viewModels[indexPath.row]
        let albumName = album.name
        let artist = album.artist
        album.downloadImage({ (image) in
            DispatchQueue.main.async {
                cell.artView.image = image
            }
        }) {
            cell.showPlaceholderArt()
        }
        cell.albumLabel.text = albumName
        cell.artistLabel.text = artist
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = DetailsViewController()
        let cell = tableView.cellForRow(at: indexPath) as? ListCell
        let album = self.viewModel.viewModels[indexPath.row]
        detailsVC.albumViewModel = album
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
