import UIKit

class ExchangeController: UIViewController, UIScrollViewDelegate {
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.text = "Exchange rates".localize()
        view.font = .systemFont(ofSize: 34, weight: .bold)
        view.textAlignment = .left

        return view
    }()

    private lazy var btnEdit: UIButton = {
        var btn = UIButton()
        btn.backgroundColor = .clear
        btn.setTitle("Edit".localize(), for: .normal)
        btn.setTitleColor(UIColor(red: 0.04, green: 0.52, blue: 1, alpha: 1), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        btn.addTarget(self, action: #selector(pushVC), for: .touchUpInside)

        return btn
    }()

    private lazy var imgView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "russia")
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pushCountry)))

        return view
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(ExchangeCell.self, forCellWithReuseIdentifier: "ExchangeCell")
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false

        return view
    }()

    private var currencies = UserData.stringExchange

    private var convert: [(String, Double, String, UIImage?)] = [
        ("USD", 1.0, "$", UIImage(named: "usa")),
        ("GBP", 1.2716, "£", UIImage(named: "united")),
        ("AUD", 0.64, "$", UIImage(named: "australia")),
        ("BRL", 0.2011, "R$", UIImage(named: "brazil")),
        ("CAD", 0.7379, "$", UIImage(named: "canada")),
        ("CNY", 0.1366, "¥", UIImage(named: "china")),
        ("INR", 0.0121, "₹", UIImage(named: "india")),
        ("IDR", 0.000065, "Rp", UIImage(named: "indonesia")),
        ("ILR", 0.26, "₪", UIImage(named: "israel")),
        ("JPY", 0.0069, "¥", UIImage(named: "japan")),
        ("MXN", 0.059, "$", UIImage(named: "mexico")),
        ("RUB", 0.0106, "₽", UIImage(named: "russia")),
        ("TRY", 0.037, "₺", UIImage(named: "turkey"))
    ]

    let currensiesUD = Array(UserData.currenciesNew)

    private var percent = 0.0106
    private var sign = "₽"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1)
        navigationController?.navigationBar.isHidden = true

        view.addSubviews(titleLabel, btnEdit, imgView, collectionView)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        titleLabel.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: 18).isActive = true

        btnEdit.translatesAutoresizingMaskIntoConstraints = false
        btnEdit.centerYAnchor.constraint(equalTo: imgView.centerYAnchor).isActive = true
        btnEdit.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true

        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        imgView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        imgView.widthAnchor.constraint(equalToConstant: 24).isActive = true

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -1).isActive = true

        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension ExchangeController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        currencies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExchangeCell", for: indexPath) as! ExchangeCell
        cell.setup(data: currencies[indexPath.row])

        var value = 0.0
        for i in currensiesUD {
            if i.key == currencies[indexPath.row] {
                value = i.value
                print(i, value)
            }
        }

        let result = (value) / percent
        cell.valueLabel.text = "\(Double(round(100 * result) / 100)) \(sign)"

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (collectionView.frame.width), height: 56)
    }
}

extension ExchangeController {
    @objc private func pushVC() {
        let vc = CurrencyController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: false)
    }

    @objc private func pushCountry() {
        let vc = CountryController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: false)
    }
}

extension ExchangeController: CountryDelegate {
    func updateCountry(_ value: String?) {
        for item in convert {
            if item.0 == value {
                percent = item.1
                sign = item.2
                imgView.image = item.3
            }
        }
        collectionView.reloadData()
    }
}

extension ExchangeController: CurrencyDelegate {
    func updateCurrency(_ value: [String]?) {
        currencies = value ?? []
        collectionView.reloadData()
    }
}
