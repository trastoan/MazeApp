//
//  ShowListController.swift
//  MazeApp
//
//  Created by Yuri on 24/04/22.
//

import Foundation
import UIKit

protocol ShowListView {
    var model: ShowListModel! { get }
}

class ShowListController: UIViewController, ShowListView {
    var model: ShowListModel!

    let collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(ShowCollectionViewCell.self)
        collection.backgroundColor = .defaultBackground
        collection.contentInsetAdjustmentBehavior = .always
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = model.title

        setupCollection()
        setupConfigurationsButton()

        setupSubviews()
        setupConstraints()

        setupModelCallback()

        Task {
            try await model.fetch()
        }
    }

    private func setupCollection() {
        collection.delegate = self
        collection.dataSource = self
        collection.prefetchDataSource = self
    }

    func setupConfigurationsButton() {
        let barButton = UIBarButtonItem(title: nil,
                                        image: UIImage(systemName: "gear"),
                                        primaryAction: UIAction(handler: { _ in self.model.showConfigurations() }))

        navigationItem.setRightBarButton(barButton, animated: false)
    }

    private func setupModelCallback() {
        model.hasFinishedFetch = { [weak self] in
            self?.collection.reloadData()
        }

        model.insertNewShows = { [weak self] indexes in
            self?.collection.insertItems(at: indexes)
        }
    }

    private func setupSubviews() {
        view.addSubview(collection)
    }

    private func setupConstraints() {
        collection.centerOn(view: view)
    }
}

extension ShowListController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.numberofShows
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as ShowCollectionViewCell
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? ShowCollectionViewCell else { return }
        let show = model.show(for: indexPath.row)
        cell.setup(show)
    }

    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        let itemsBeforePrefetch = 30
        let newFetchTrigger = model.numberofShows - itemsBeforePrefetch
        if let firstIndex = indexPaths.first?.row,
           firstIndex >= newFetchTrigger {
            Task {
                try await model.fetchNextPage()
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        model.showDetails(for: indexPath.row)
    }
}

extension ShowListController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        var size: CGSize

        let width = UIScreen.main.bounds.width

        let navBarHeight = self.navigationController?.navigationBar.frame.height ?? 0
        let tabBarHeight = self.tabBarController?.tabBar.frame.height ?? 0
        let height = UIScreen.main.bounds.height - (navBarHeight + tabBarHeight)

        if width < height {
            let cellWidth = width / 2
            let cellHeight = cellWidth * 1.75
            size = CGSize(width: cellWidth, height: cellHeight)
        } else {
            let cellHeight = height
            let cellWidth = cellHeight * 0.58
            size = CGSize(width: cellWidth, height: cellHeight)
        }
        return size
    }
}
