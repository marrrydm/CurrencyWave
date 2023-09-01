import AppsFlyerLib
import AppTrackingTransparency
import FirebaseAnalytics
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
        view.textColor = .black
        view.text = "onb3".localize()
        view.font = .systemFont(ofSize: 24, weight: .bold)
        view.numberOfLines = 0
        view.textAlignment = .center
        view.lineBreakMode = .byWordWrapping

        return view
    }()

    private lazy var nextButton: UIButton = {
        let nextButton = UIButton()
        nextButton.backgroundColor = UIColor(red: 0.945, green: 0.741, blue: 0.349, alpha: 1)
        nextButton.layer.cornerRadius = 14
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.setTitle("btn".localize(), for: .normal)
        nextButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        nextButton.addTarget(self, action: #selector(nextVC), for: .touchUpInside)

        return nextButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.969, alpha: 1)

        setupViews()
        makeConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        AppsFlyerLib.shared().logEvent("onboarding_finish", withValues: nil)
        Analytics.logEvent("onboarding_finish", parameters: nil)

        ATTrackingManager.requestTrackingAuthorization { status in
            switch status {
            case .authorized:
                print("The user has granted access.")
            case .denied, .restricted:
                print("The user has denied access.")
            case .notDetermined:
                print("The user has not yet received an authorization request.")
            @unknown default:
                break
            }
        }
    }

    private func setupViews() {
        view.addSubviews(logoView, labelTitle, nextButton)
    }

    private func makeConstraints() {
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -50).isActive = true
        labelTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        labelTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true

        logoView.translatesAutoresizingMaskIntoConstraints = false
        logoView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        logoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 38).isActive = true
        logoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -38).isActive = true
        logoView.heightAnchor.constraint(equalToConstant: 330).isActive = true
    }
}

extension ThirdVC {
    @objc private func nextVC() {
        let vc = TabBarController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
}
