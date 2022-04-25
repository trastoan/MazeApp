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

    private let segmentedControl: UISegmentedControl = {
        let segment = UISegmentedControl()
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.backgroundColor = .systemBackground
        segment.selectedSegmentIndex = 0
        return segment
    }()

    private let searchController = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = model.title

        table.dataSource = self
        table.delegate = self

        setupSearchBar()
        setupSegmentBar()

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

    private func setupSegmentBar() {
        for (index,searchType) in model.searchTypes.enumerated() {
            let title = searchType.rawValue.capitalized
            segmentedControl.insertSegment(withTitle: title, at: index, animated: false)
        }
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedChanged(_:)), for: .valueChanged)
    }

    @objc
    private func segmentedChanged(_ segmented: UISegmentedControl) {
        model.changeSearch(index: segmented.selectedSegmentIndex)
        guard let name = searchController.searchBar.text else {
            model.resetSearch()
            return
        }
        searchFor(name: name)
    }

    private func setupSubviews() {
        self.view.addSubview(table)
        self.view.addSubview(segmentedControl)
    }

    private func searchFor(name: String) {
        if name.count > 1 {
            Task {
                try await model.search(for: name)
            }
        } else {
            model.resetSearch()
        }
    }

    private func setupConstraints() {

        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            segmentedControl.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            segmentedControl.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),

            self.table.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            self.table.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            self.table.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            self.table.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension SearchView: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let name = searchController.searchBar.text else { return }
        searchFor(name: name)
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
