//
//  SearchController.swift
//  MazeApp
//
//  Created by Yuri on 24/04/22.
//

import UIKit

protocol SearchViewProtocol {
    var model: SearchViewModel! { get }
}

class SearchView: UIViewController, SearchViewProtocol {
    var model: SearchViewModel!

    private let table: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .singleLine
        table.tableFooterView = UIView()
        table.register(SearchTableViewCell.self)
        table.rowHeight = 124
        return table
    }()

    private let searchController = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = model.title
        table.dataSource = self
        table.delegate = self

        setupSearchBar()
        setupSubviews()
        setupConstraints()

        configureSearchCallback()
    }

    private func configureSearchCallback() {
        model.hasFinishedSearching = { [weak self] in
            self?.table.reloadData()
        }
    }

    private func setupSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for movies"
        searchController.searchBar.searchTextField.backgroundColor = .systemBackground
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .black

        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        definesPresentationContext = true 
    }

    private func setupSubviews() {
        self.view.addSubview(table)
    }

    private func setupConstraints() {
        table.centerOn(view: view)
    }
}

extension SearchView: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let name = searchController.searchBar.text else { return }
        if name.count > 1 {
            Task {
                try await model.search(for: name)
            }
        } else {
            model.resetSearch()
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        model.resetSearch()
    }
}

extension SearchView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.numberOfResults
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as SearchTableViewCell
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let searchCell = cell as? SearchTableViewCell else { return }
        let cellModel = model.model(for: indexPath.row)
        searchCell.setup(with: cellModel)
    }

}
