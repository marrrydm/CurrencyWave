import UIKit

class SettingController: UIViewController, UIScrollViewDelegate {
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.text = "Setting".localize()
        view.font = .systemFont(ofSize: 34, weight: .bold)
        view.textAlignment = .left

        return view
    }()

    private lazy var privacyView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 14
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(policyAction)))

        return view
    }()

    private let privacyViewLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.14, green: 0.14, blue: 0.15, alpha: 1)
        view.text = "account.policy".localize()
        view.font = .systemFont(ofSize: 17, weight: .medium)

        return view
    }()

    private lazy var termsView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.isUserInteractionEnabled = true
        view.layer.cornerRadius = 14
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(termsAction)))

        return view
    }()

    private let termsViewLabel: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.14, green: 0.14, blue: 0.15, alpha: 1)
        view.text = "account.terms".localize()
        view.font = .systemFont(ofSize: 17, weight: .medium)

        return view
    }()

    private let privacyImg = UIImageView(image: UIImage(named: "right"))
    private let termsImg = UIImageView(image: UIImage(named: "right"))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1)
        navigationController?.navigationBar.isHidden = true

        view.addSubviews(titleLabel, privacyView, termsView)

        privacyView.addSubviews(privacyViewLabel, privacyImg)
        termsView.addSubviews(termsViewLabel, termsImg)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true

        privacyView.translatesAutoresizingMaskIntoConstraints = false
        privacyView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 18).isActive = true
        privacyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        privacyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        privacyView.heightAnchor.constraint(equalToConstant: 44).isActive = true

        privacyViewLabel.translatesAutoresizingMaskIntoConstraints = false
        privacyViewLabel.centerYAnchor.constraint(equalTo: privacyView.centerYAnchor).isActive = true
        privacyViewLabel.leadingAnchor.constraint(equalTo: privacyView.leadingAnchor, constant: 16).isActive = true

        privacyImg.translatesAutoresizingMaskIntoConstraints = false
        privacyImg.centerYAnchor.constraint(equalTo: privacyView.centerYAnchor).isActive = true
        privacyImg.trailingAnchor.constraint(equalTo: privacyView.trailingAnchor, constant: -16).isActive = true
        privacyImg.heightAnchor.constraint(equalToConstant: 13).isActive = true
        privacyImg.widthAnchor.constraint(equalToConstant: 13).isActive = true

        termsView.translatesAutoresizingMaskIntoConstraints = false
        termsView.topAnchor.constraint(equalTo: privacyView.bottomAnchor, constant: 1).isActive = true
        termsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        termsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        termsView.heightAnchor.constraint(equalToConstant: 44).isActive = true

        termsViewLabel.translatesAutoresizingMaskIntoConstraints = false
        termsViewLabel.centerYAnchor.constraint(equalTo: termsView.centerYAnchor).isActive = true
        termsViewLabel.leadingAnchor.constraint(equalTo: termsView.leadingAnchor, constant: 16).isActive = true

        termsImg.translatesAutoresizingMaskIntoConstraints = false
        termsImg.centerYAnchor.constraint(equalTo: termsView.centerYAnchor).isActive = true
        termsImg.trailingAnchor.constraint(equalTo: termsView.trailingAnchor, constant: -16).isActive = true
        termsImg.heightAnchor.constraint(equalToConstant: 13).isActive = true
        termsImg.widthAnchor.constraint(equalToConstant: 13).isActive = true
    }
}


extension SettingController {
    @objc private func policyAction() {
        if let url = URL(string: "https://www.freeprivacypolicy.com/live/649c057d-4844-46a3-8526-21f0dc8f9354"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    @objc private func termsAction() {
        if let url = URL(string: "https://www.freeprivacypolicy.com/live/2d135edd-4740-4839-b7e7-9278478c63c9"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

class GrdientView: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    private lazy var gradientLayer: CAGradientLayer = {
        let l = CAGradientLayer()
        l.frame = self.bounds
        l.colors = [UIColor(red: 0.339, green: 0.339, blue: 0.387, alpha: 1).cgColor, UIColor(red: 0.097, green: 0.097, blue: 0.1, alpha: 1).cgColor]
        l.startPoint = CGPoint(x: 0, y: 0.5)
        l.endPoint = CGPoint(x: 1, y: 0.5)
        l.cornerRadius = 13
        layer.insertSublayer(l, at: 0)
        return l
    }()
}
