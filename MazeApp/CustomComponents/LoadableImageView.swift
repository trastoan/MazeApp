//
//  LoadableImageView.swift
//  MazeApp
//
//  Created by Yuri on 24/04/22.
//

import UIKit
import Nuke

class LoadableImageView: UIImageView {
    let loadingIndicator = UIActivityIndicatorView()

    override init(image: UIImage?) {
        super.init(image: image)
        loadingIndicator.setupOn(view: self)
    }

    init() {
        super.init(frame: .zero)
        loadingIndicator.setupOn(view: self)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadingIndicator.setupOn(view: self)
    }

    func loadImage(withURL url: URL?, defaultImage: UIImage = UIImage(named: "NoPoster")!) {

        loadingIndicator.startAnimating()
        Nuke.cancelRequest(for: self)
        self.image = nil

        guard let imageURL = url else {
            loadingIndicator.stopAnimating()
            self.image = defaultImage
            return
        }

        Nuke.loadImage(with: imageURL, into: self) { result in
            self.loadingIndicator.stopAnimating()
            switch result {
                case .success(let response):
                    self.image = response.image
                case .failure:
                    self.image = defaultImage
            }
        }
    }
}
