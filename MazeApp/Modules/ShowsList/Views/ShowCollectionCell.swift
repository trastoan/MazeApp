//
//  ShowCollectionCell.swift
//  MazeApp
//
//  Created by Yuri on 24/04/22.
//

import UIKit

class ShowCollectionViewCell: UICollectionViewCell {

    let showPosterImage: LoadableImageView = {
        let imageView = LoadableImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    let dateHeaderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(displayP3Red: 0.15, green: 0.15, blue: 0.15, alpha: 0.7)
        return view
    }()

    let genresLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.font(named: "Helvetica", size: 10, weight: .bold)
        label.textColor = .appMainColor
        return label
    }()

    let shadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.font(named: "Helvetica", size: 14, weight: .bold)
        return label
    }()

    let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.font(named: "Helvetica", size: 14, weight: .bold)
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.71)
        return label
    }()

    override func prepareForReuse() {
        super.prepareForReuse()
        showPosterImage.image = nil
        genresLabel.text = ""
        titleLabel.text = ""
        statusLabel.text = ""
    }

    func setup(_ show: Show) {
        titleLabel.text = show.name
        genresLabel.text = show.genres.joined(separator: " ")
        statusLabel.text = show.status
        showPosterImage.loadImage(withURL: URL(string: show.image?.medium ?? ""))
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        shadowView.dropShadow(withOpacity: 1.5)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        self.addSubview(shadowView)
        self.addSubview(showPosterImage)
        self.addSubview(dateHeaderView)
        self.addSubview(statusLabel)
        self.addSubview(genresLabel)
        self.addSubview(titleLabel)
    }

    private func setupConstraints() {

        NSLayoutConstraint.activate([
            showPosterImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            showPosterImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            showPosterImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8),
            showPosterImage.heightAnchor.constraint(equalTo: showPosterImage.widthAnchor, multiplier: 1.42),

            dateHeaderView.topAnchor.constraint(equalTo: showPosterImage.topAnchor),
            dateHeaderView.widthAnchor.constraint(equalTo: showPosterImage.widthAnchor),
            dateHeaderView.heightAnchor.constraint(equalToConstant: 32),
            dateHeaderView.centerXAnchor.constraint(equalTo: showPosterImage.centerXAnchor),

            shadowView.centerXAnchor.constraint(equalTo: showPosterImage.centerXAnchor),
            shadowView.centerYAnchor.constraint(equalTo: showPosterImage.centerYAnchor),
            shadowView.widthAnchor.constraint(equalTo: showPosterImage.widthAnchor),
            shadowView.heightAnchor.constraint(equalTo: showPosterImage.heightAnchor),

            statusLabel.centerXAnchor.constraint(equalTo: dateHeaderView.centerXAnchor),
            statusLabel.centerYAnchor.constraint(equalTo: dateHeaderView.centerYAnchor),

            titleLabel.topAnchor.constraint(equalTo: showPosterImage.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),

            genresLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            genresLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            genresLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            genresLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -4)

        ])
    }
}
