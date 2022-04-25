//
//  SearchTableViewCell.swift
//  MazeApp
//
//  Created by Yuri on 24/04/22.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    let posterImageView: LoadableImageView = {
        let imageView = LoadableImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.font(named: "Helvetica", size: 18, weight: .bold)
        label.numberOfLines = 2
        return label
    }()

    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.font(named: "Helvetica", size: 14, weight: .bold)
        label.numberOfLines = 2
        return label
    }()

    override func prepareForReuse() {
        nameLabel.text = ""
        subtitleLabel.text = ""
        posterImageView.image = nil
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(with model: SearchTableCellModel) {
        self.selectionStyle = .none
        nameLabel.text = model.name
        subtitleLabel.text = model.subtitle
        posterImageView.loadImage(withURL: URL(string: model.image ?? ""))
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.dropShadow(withOpacity: 1)
    }

    func setupSubviews() {
        self.addSubview(posterImageView)
        self.addSubview(nameLabel)
        self.addSubview(subtitleLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            posterImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            posterImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            posterImageView.heightAnchor.constraint(equalTo: posterImageView.widthAnchor, multiplier: 1.4),

            nameLabel.leftAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: 8),
            nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8),
            nameLabel.centerYAnchor.constraint(equalTo: posterImageView.centerYAnchor),

            subtitleLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            subtitleLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor)

        ])
    }
}
