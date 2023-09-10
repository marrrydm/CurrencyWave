import StoreKit
import UIKit

class SecondVC: UIViewController {
    private let view1: GrdientView = {
        let view = GrdientView()
        return view
    }()

    private let view2: GrdientView = {
        let view = GrdientView()
        return view
    }()

    private let view3: GrdientView = {
        let view = GrdientView()
        return view
    }()

    private let person1: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "per1")
        view.contentMode = .scaleAspectFit
        return view
    }()

    private let person2: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "per2")
        view.contentMode = .scaleAspectFit
        return view
    }()

    private let person3: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "per3")
        view.contentMode = .scaleAspectFit
        return view
    }()

    private let starts1: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "stars")
        view.contentMode = .scaleAspectFit
        return view
    }()

    private let starts2: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "stars")
        view.contentMode = .scaleAspectFit
        return view
    }()

    private let starts3: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "stars")
        view.contentMode = .scaleAspectFit
        return view
    }()

    private let name1: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.949, green: 0.949, blue: 0.969, alpha: 1)
        view.text = "name1".localize()
        view.font = .systemFont(ofSize: 14, weight: .bold)
        view.textAlignment = .left
        return view
    }()

    private let name2: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.949, green: 0.949, blue: 0.969, alpha: 1)
        view.text = "name2".localize()
        view.font = .systemFont(ofSize: 14, weight: .bold)
        view.textAlignment = .left
        return view
    }()

    private let name3: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.949, green: 0.949, blue: 0.969, alpha: 1)
        view.text = "name3".localize()
        view.font = .systemFont(ofSize: 14, weight: .bold)
        view.textAlignment = .left
        return view
    }()

    private let comment1: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.82, green: 0.82, blue: 0.839, alpha: 1)
        view.text = "comment1".localize()
        view.font = .systemFont(ofSize: 14, weight: .regular)
        view.numberOfLines = 0
        view.textAlignment = .left
        view.lineBreakMode = .byWordWrapping
        return view
    }()

    private let comment2: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.82, green: 0.82, blue: 0.839, alpha: 1)
        view.text = "comment2".localize()
        view.font = .systemFont(ofSize: 14, weight: .regular)
        view.numberOfLines = 0
        view.textAlignment = .left
        view.lineBreakMode = .byWordWrapping
        return view
    }()

    private let comment3: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.82, green: 0.82, blue: 0.839, alpha: 1)
        view.text = "comment3".localize()
        view.font = .systemFont(ofSize: 14, weight: .regular)
        view.numberOfLines = 0
        view.textAlignment = .left
        view.lineBreakMode = .byWordWrapping
        return view
    }()

    private let labelTitle: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.949, green: 0.949, blue: 0.969, alpha: 1)
        view.text = "onb2.1".localize()
        view.font = .systemFont(ofSize: 34, weight: .bold)
        view.numberOfLines = 0
        view.textAlignment = .left
        view.lineBreakMode = .byWordWrapping
        return view
    }()

    private let labelDescription: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(red: 0.82, green: 0.82, blue: 0.839, alpha: 1)
        view.text = "onb2.2".localize()
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
        view.addSubviews(labelTitle, nextButton, labelDescription,  view1, view2, view3)
        view1.addSubviews(person1, name1, starts1, comment1)
        view2.addSubviews(person2, name2, starts2, comment2)
        view3.addSubviews(person3, name3, starts3, comment3)
    }

    private func makeConstraints() {
        view1.translatesAutoresizingMaskIntoConstraints = false
        view1.bottomAnchor.constraint(equalTo: view2.topAnchor, constant: 6).isActive = true
        view1.widthAnchor.constraint(equalToConstant: 244).isActive = true
        view1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45).isActive = true
        view1.topAnchor.constraint(equalTo: person1.topAnchor, constant: -16).isActive = true

        starts1.translatesAutoresizingMaskIntoConstraints = false
        starts1.bottomAnchor.constraint(equalTo: person1.centerYAnchor, constant: -2).isActive = true
        starts1.leadingAnchor.constraint(equalTo: person1.trailingAnchor, constant: 10).isActive = true

        name1.translatesAutoresizingMaskIntoConstraints = false
        name1.topAnchor.constraint(equalTo: person1.centerYAnchor, constant: 2).isActive = true
        name1.leadingAnchor.constraint(equalTo: person1.trailingAnchor, constant: 10).isActive = true

        person1.translatesAutoresizingMaskIntoConstraints = false
        person1.bottomAnchor.constraint(equalTo: comment1.topAnchor, constant: -10).isActive = true
        person1.leadingAnchor.constraint(equalTo: view1.leadingAnchor, constant: 16).isActive = true
        person1.heightAnchor.constraint(equalToConstant: 44).isActive = true
        person1.widthAnchor.constraint(equalToConstant: 44).isActive = true

        comment1.translatesAutoresizingMaskIntoConstraints = false
        comment1.bottomAnchor.constraint(equalTo: view1.bottomAnchor, constant: -16).isActive = true
        comment1.trailingAnchor.constraint(equalTo: view1.trailingAnchor, constant: -16).isActive = true
        comment1.leadingAnchor.constraint(equalTo: view1.leadingAnchor, constant: 16).isActive = true

        view2.translatesAutoresizingMaskIntoConstraints = false
        view2.bottomAnchor.constraint(equalTo: view3.topAnchor, constant: 6).isActive = true
        view2.widthAnchor.constraint(equalToConstant: 244).isActive = true
        view2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        view2.topAnchor.constraint(equalTo: person2.topAnchor, constant: -16).isActive = true

        starts2.translatesAutoresizingMaskIntoConstraints = false
        starts2.bottomAnchor.constraint(equalTo: person2.centerYAnchor, constant: -2).isActive = true
        starts2.leadingAnchor.constraint(equalTo: person2.trailingAnchor, constant: 10).isActive = true

        name2.translatesAutoresizingMaskIntoConstraints = false
        name2.topAnchor.constraint(equalTo: person2.centerYAnchor, constant: 2).isActive = true
        name2.leadingAnchor.constraint(equalTo: person2.trailingAnchor, constant: 10).isActive = true

        person2.translatesAutoresizingMaskIntoConstraints = false
        person2.bottomAnchor.constraint(equalTo: comment2.topAnchor, constant: -10).isActive = true
        person2.leadingAnchor.constraint(equalTo: view2.leadingAnchor, constant: 16).isActive = true
        person2.heightAnchor.constraint(equalToConstant: 44).isActive = true
        person2.widthAnchor.constraint(equalToConstant: 44).isActive = true

        comment2.translatesAutoresizingMaskIntoConstraints = false
        comment2.bottomAnchor.constraint(equalTo: view2.bottomAnchor, constant: -16).isActive = true
        comment2.trailingAnchor.constraint(equalTo: view2.trailingAnchor, constant: -16).isActive = true
        comment2.leadingAnchor.constraint(equalTo: view2.leadingAnchor, constant: 16).isActive = true

        view3.translatesAutoresizingMaskIntoConstraints = false
        view3.bottomAnchor.constraint(equalTo: labelTitle.topAnchor, constant: -30).isActive = true
        view3.widthAnchor.constraint(equalToConstant: 244).isActive = true
        view3.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        view3.topAnchor.constraint(equalTo: person3.topAnchor, constant: -16).isActive = true

        starts3.translatesAutoresizingMaskIntoConstraints = false
        starts3.bottomAnchor.constraint(equalTo: person3.centerYAnchor, constant: -2).isActive = true
        starts3.leadingAnchor.constraint(equalTo: person3.trailingAnchor, constant: 10).isActive = true

        name3.translatesAutoresizingMaskIntoConstraints = false
        name3.topAnchor.constraint(equalTo: person3.centerYAnchor, constant: 2).isActive = true
        name3.leadingAnchor.constraint(equalTo: person3.trailingAnchor, constant: 10).isActive = true

        person3.translatesAutoresizingMaskIntoConstraints = false
        person3.bottomAnchor.constraint(equalTo: comment3.topAnchor, constant: -10).isActive = true
        person3.leadingAnchor.constraint(equalTo: view3.leadingAnchor, constant: 16).isActive = true
        person3.heightAnchor.constraint(equalToConstant: 44).isActive = true
        person3.widthAnchor.constraint(equalToConstant: 44).isActive = true

        comment3.translatesAutoresizingMaskIntoConstraints = false
        comment3.bottomAnchor.constraint(equalTo: view3.bottomAnchor, constant: -16).isActive = true
        comment3.trailingAnchor.constraint(equalTo: view3.trailingAnchor, constant: -16).isActive = true
        comment3.leadingAnchor.constraint(equalTo: view3.leadingAnchor, constant: 16).isActive = true

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
        labelDescription.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -40).isActive = true
        labelDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        labelDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
    }
}

extension SecondVC {
    @objc private func nextVC() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
            let vc = ThirdVC()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false)
        }
    }
}

