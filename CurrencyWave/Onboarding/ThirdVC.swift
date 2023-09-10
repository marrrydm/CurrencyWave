import AppsFlyerLib
import FirebaseAnalytics
import OneSignal
import UIKit

class ThirdVC: UIViewController {
    private let logoView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "pic3")
        view.contentMode = .scaleAspectFit

        return view
    }()

    private let labelTitle: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.949, green: 0.949, blue: 0.969, alpha: 1)
        view.text = "onb3.1".localize()
        view.font = .systemFont(ofSize: 34, weight: .bold)
        view.numberOfLines = 0
        view.textAlignment = .left
        view.lineBreakMode = .byWordWrapping
        return view
    }()

    private let labelDescription: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.82, green: 0.82, blue: 0.839, alpha: 1)
        view.text = "onb3.2".localize()
        view.font = .systemFont(ofSize: 17, weight: .regular)
        view.numberOfLines = 0
        view.textAlignment = .left
        view.lineBreakMode = .byWordWrapping
        return view
    }()

    private lazy var nextButton: UIButton = {
        let nextButton = UIButton()
        nextButton.backgroundColor = UIColor(red: 0.255, green: 0.573, blue: 0.969, alpha: 1)
        nextButton.layer.cornerRadius = 14
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.setTitle("btn".localize(), for: .normal)
        nextButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        nextButton.addTarget(self, action: #selector(nextVC), for: .touchUpInside)

        return nextButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.122, green: 0.129, blue: 0.149, alpha: 1)

        setupViews()
        makeConstraints()
    }

    private func setupViews() {
        view.addSubviews(logoView, labelTitle, nextButton, labelDescription)
    }

    private func makeConstraints() {
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.bottomAnchor.constraint(equalTo: labelDescription.topAnchor, constant: -12).isActive = true
        labelTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        labelTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true

        labelDescription.translatesAutoresizingMaskIntoConstraints = false
        labelDescription.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -20).isActive = true
        labelDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        labelDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true

        logoView.translatesAutoresizingMaskIntoConstraints = false
        logoView.bottomAnchor.constraint(equalTo: labelTitle.topAnchor, constant: -60).isActive = true
        logoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38).isActive = true
        logoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -38).isActive = true
        logoView.heightAnchor.constraint(equalToConstant: 307).isActive = true
    }
}

extension ThirdVC {
    @objc private func nextVC() {
        AppsFlyerLib.shared().logEvent("onboarding_finish", withValues: nil)
        Analytics.logEvent("onboarding_finish", parameters: nil)

        OneSignal.promptForPushNotifications(userResponse: { [weak self] accepted in
            let vc = TabBarController()
            vc.modalPresentationStyle = .fullScreen
            self?.present(vc, animated: true)
        })
    }
}
