import AppsFlyerLib
import FirebaseAnalytics
import UIKit

class PreloaderController: UIViewController {
    private let logoView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "logoImg")
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        AppsFlyerLib.shared().logEvent("onboarding_start", withValues: nil)
        Analytics.logEvent("onboarding_start", parameters: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1)

        view.addSubview(logoView)

        NSLayoutConstraint.activate([
            logoView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            logoView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            logoView.heightAnchor.constraint(equalToConstant: 79),
            logoView.widthAnchor.constraint(equalToConstant: 79)
        ])

        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            if (UserDefaults.standard.string(forKey: "showedOnboarding") != nil) == true {
                let vc = TabBarController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            } else {
                UserDefaults.standard.set(true, forKey: "showedOnboarding")
                let vc = FirstVC()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }
        })
    }
}

public extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}

extension String {
    func localize() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
