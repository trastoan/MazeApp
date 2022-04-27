//
//  PinRegistrationViewController.swift
//  MazeApp
//
//  Created by Yuri on 27/04/22.
//

import UIKit

class PinRegistrationViewController: UIViewController {
    var model: PinRegistrationViewModelProtocol

    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.isUserInteractionEnabled = false
        scroll.backgroundColor = .clear
        return scroll
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    private let pinView = PinInputView(with: "Choose Your Pin", pinSize: 6)
    private let confirmationPinView = PinInputView(with: "Repeat Your Pin", pinSize: 6)

    init(model: PinRegistrationViewModelProtocol) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pin Registration"
        view.backgroundColor = .appMainColor

        setupCancelButton()
        setupSubviews()
        setupConstraints()
        model.failedConfirmation = {
            self.wrongConfirmation()
        }

        pinView.delegate = self
        confirmationPinView.delegate = self

        pinView.beginUserInput()
    }

    private func setupSubviews() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(pinView)
        contentView.addSubview(confirmationPinView)

        pinView.translatesAutoresizingMaskIntoConstraints = false
        confirmationPinView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupConstraints() {

        let frameGuide = scrollView.frameLayoutGuide
        let contentGuide = scrollView.contentLayoutGuide

        NSLayoutConstraint.activate([
            frameGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            frameGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            frameGuide.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            frameGuide.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),

            contentGuide.heightAnchor.constraint(equalTo: frameGuide.heightAnchor),
            contentView.widthAnchor.constraint(equalTo: frameGuide.widthAnchor, multiplier: 2),

            contentView.topAnchor.constraint(equalTo: contentGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: contentGuide.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: contentGuide.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: contentGuide.rightAnchor),

            pinView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pinView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -80),
            pinView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),

            confirmationPinView.leadingAnchor.constraint(equalTo: pinView.trailingAnchor),
            confirmationPinView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            confirmationPinView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -80),
        ])
    }

    private func setupCancelButton() {
        let action = UIAction { [weak self] _ in self?.model.cancelRegistration() }
        let barButton = UIBarButtonItem(systemItem: .cancel, primaryAction: action)
        barButton.tintColor = .white

        navigationItem.setRightBarButton(barButton, animated: false)
    }

    private func wrongConfirmation() {
        UIView.animate(withDuration: 0.5) {
            self.view.backgroundColor = .systemRed
            self.confirmationPinView.changeMessage("Pin doesn't match")
        } completion: { _ in
            self.view.backgroundColor = .appMainColor
            self.confirmationPinView.changeMessage("Repeat your pin")
            self.scrollToBegin()
        }

    }

    private func scrollToBegin() {
        let y = scrollView.contentOffset.y

        scrollView.setContentOffset(CGPoint(x: 0, y: y), animated: true)
        pinView.beginUserInput()
    }

    private func scrollToConfirmation() {
        let x = contentView.frame.width/2
        let y = scrollView.contentOffset.y

        scrollView.setContentOffset(CGPoint(x: x, y: y), animated: true)
        confirmationPinView.beginUserInput()
    }
}

extension PinRegistrationViewController: PinInputViewDelegate {
    func didFinishInput(_ inputView: PinInputView, pin: String) {
        if inputView == pinView {
            scrollToConfirmation()
            model.storePin(pin)

        } else {
            model.checkPin(pin)
        }
    }
}
