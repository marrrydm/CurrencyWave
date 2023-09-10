import UIKit

final class PreloaderController: UIViewController {
    private let logoView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "logoImg")
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.122, green: 0.129, blue: 0.149, alpha: 1)

        view.addSubview(logoView)

        NSLayoutConstraint.activate([
            logoView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            logoView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            logoView.heightAnchor.constraint(equalToConstant: 69),
            logoView.widthAnchor.constraint(equalToConstant: 69)
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
