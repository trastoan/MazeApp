//
//  SearchController.swift
//  MazeApp
//
//  Created by Yuri on 24/04/22.
//

import UIKit
import Combine

class SearchView: UIViewController {
    var model: SearchViewModel!

    private let table: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .singleLine
        table.tableFooterView = UIView()
        table.register(SearchTableViewCell.self)
        table.backgroundColor = .defaultBackground
        table.rowHeight = 124
        return table
    }()

    private let segmentedControl: UISegmentedControl = {
        let segment = UISegmentedControl()
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.backgroundColor = .segmentedBackground
        segment.selectedSegmentIndex = 0
        return segment
    }()

    private let loadingIndicator = UIActivityIndicatorView()

    private var bag = Set<AnyCancellable>()

    private let searchController = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = model.title
        view.backgroundColor = .defaultBackground

        table.dataSource = self
        table.delegate = self

        setupSearchBar()
        setupSegmentBar()

        setupSubviews()
        setupConstraints()

        listenForSearch()
        configureSearchCallback()
    }

    private func configureSearchCallback() {
        model.hasFinishedSearching = { [weak self] in
            self?.animateLoadIndicator(isLoading: false)
            self?.table.reloadData()
        }
    }

    private func listenForSearch() {
        let publisher = NotificationCenter.default.publisher(for: UISearchTextField.textDidChangeNotification, object: searchController.searchBar.searchTextField)
        publisher.map({
            ($0.object as? UISearchTextField)?.text
        })
        .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
        .removeDuplicates()
        .sink { searchText in
            self.searchFor(name: searchText ?? "")
        }.store(in: &bag)
    }

    private func setupSearchBar() {
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for shows"
        searchController.searchBar.searchTextField.backgroundColor = .systemBackground
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .black

        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    private func setupSegmentBar() {
        for (index, searchType) in model.searchTypes.enumerated() {
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
        let type = segmented.titleForSegment(at: segmented.selectedSegmentIndex)
        searchController.searchBar.placeholder = "Search for \(type!.lowercased())"
    }

    private func setupSubviews() {
        self.view.addSubview(table)
        self.view.addSubview(segmentedControl)
    }

    private func searchFor(name: String) {
        if name.count > 1 {
            animateLoadIndicator(isLoading: true)
            Task {
                try await model.search(for: name)
            }
        } else {
            model.resetSearch()
        }
    }

    private func setupConstraints() {
        loadingIndicator.setupOn(view: view)
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            segmentedControl.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 8),
            segmentedControl.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -8),

            self.table.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            self.table.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            self.table.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            self.table.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func animateLoadIndicator(isLoading: Bool) {
        if isLoading {
            table.isHidden = true
            loadingIndicator.startAnimating()
        } else {
            table.isHidden = false
            loadingIndicator.stopAnimating()
        }
    }
}

extension SearchView: UISearchBarDelegate {
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.searchController.searchBar.resignFirstResponder()
        model.showDetails(for: indexPath.row)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let searchCell = cell as? SearchTableViewCell else { return }
        let cellModel = model.model(for: indexPath.row)
        searchCell.setup(with: cellModel)
    }

}
