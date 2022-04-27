//
//  GuardViewController.swift
//  MazeApp
//
//  Created by Yuri on 27/04/22.
//

import UIKit

class GuardViewController: UIViewController {
    var model: GuardViewModelProtocol

    let pinView = PinInputView(with: "Insert your pin", pinSize: 6)

    init(model: GuardViewModelProtocol) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        self.view.backgroundColor = .appMainColor
        title = "Insert Your pin"
        pinView.delegate = self
        
        model.defaultAuthentication = { [weak self] in
            self?.pinView.beginUserInput()
        }
        model.failedToAuthenticate = { [weak self] in
            self?.authFailed()
        }

        setupConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        model.authenticateUser()
    }

    private func setupConstraints() {
        pinView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pinView)

        NSLayoutConstraint.activate([
            pinView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 18),
            pinView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -18),
            pinView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -80)
        ])
    }

    private func authFailed() {
        UIView.animate(withDuration: 1) {
            self.view.backgroundColor = .systemRed
            self.pinView.changeMessage("Wrong pin")
        } completion: { _ in
            self.view.backgroundColor = .appMainColor
            self.pinView.beginUserInput()
            self.pinView.changeMessage("Insert your pin")
        }

    }
}

extension GuardViewController: PinInputViewDelegate {
    func didFinishInput(_ inputView: PinInputView, pin: String) {
        model.pinAuthentication(passcode: pin)
    }
}
