import UIKit

protocol CountryDelegate: AnyObject {
    func updateCountry(_ value: String?)
}

class CountryController: UIViewController {
    private let titleLabel: UILabel = {
        let labelTitle = UILabel()
        labelTitle.textColor = .black
        labelTitle.text = "Change Country".localize()
        labelTitle.font = .systemFont(ofSize: 17, weight: .semibold)
        labelTitle.textAlignment = .center

        return labelTitle
    }()

    private lazy var btnEdit: UIButton = {
        var btn = UIButton()
        btn.backgroundColor = .clear
        btn.setTitle("Done".localize(), for: .normal)
        btn.setTitleColor(UIColor(red: 0.04, green: 0.52, blue: 1, alpha: 1), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        btn.addTarget(self, action: #selector(done), for: .touchUpInside)

        return btn
    }()

    private let imgView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "russia")
        view.contentMode = .scaleAspectFit

        return view
    }()

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.isUserInteractionEnabled = true
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.allowsMultipleSelection = false
        tableView.separatorStyle = .none
        tableView.register(CountryCell.self, forCellReuseIdentifier: CountryCell.id)
        tableView.setEditing(false, animated: true)
        tableView.separatorStyle = .singleLine
        tableView.separatorInset.right = 0
        tableView.separatorInset.left = 56
        tableView.separatorColor = UIColor(red: 0.165, green: 0.169, blue: 0.196, alpha: 1)

        return tableView
    }()

    var imageView: UIImage?
    var currency: String?
    private let currencies: [(String, String)] = [
        ("United States, $", "USD"), //USD
        ("Great Britain, £", "EUR"), //EUR
        ("Australia, $", "AUD"), //AUD
        ("Brazil, R$", "BRL"), // BRL
        ("Canada, $", "CAD"), //CAD
        ("China, ¥", "CNY"), //CNY
        ("India, ₹", "INR"), //INR
        ("Indonesia, Rp", "IDR"), //IDR
        ("Israel, ₪", "ILS"), //ILS
        ("Japan, ¥", "JPY"), //JPY
        ("Mexico, $", "MXN"), //MXN
        ("Russia, ₽", "RUB"), //RUB
        ("Turkey, ₺", "TRY") //TRY
    ]

    weak var delegate: CountryDelegate?
    var num: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1)
        navigationController?.navigationBar.isHidden = true

        setupViews()
        makeConstraints()

        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imgView.image = imageView ?? UIImage(named: "russia")
    }

    private func setupViews() {
        view.addSubviews(titleLabel, btnEdit, imgView, tableView)
    }

    private func makeConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true

        btnEdit.translatesAutoresizingMaskIntoConstraints = false
        btnEdit.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        btnEdit.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true

        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        imgView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        imgView.widthAnchor.constraint(equalToConstant: 24).isActive = true

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        tableView.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 35).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

extension CountryController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currencies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CountryCell.id
        ) as? CountryCell else {
            fatalError("failed to get value cell")
        }
        cell.configure(pair: currencies[indexPath.row].0, selected: currencies[indexPath.row].0 == currency)

        if indexPath.row == 0 {
            cell.layer.cornerRadius = 14
            cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            cell.layer.masksToBounds = true
            cell.clipsToBounds = true
        }

        if indexPath.row == (currencies.count - 1) {
            cell.layer.cornerRadius = 14
            cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            cell.layer.masksToBounds = true
            cell.clipsToBounds = true

            cell.separatorInset = UIEdgeInsets(top: 0, left: cell.bounds.size.width + 50, bottom: 0, right: 0)
        } else {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 56, bottom: 0, right: 0)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

extension CountryController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currency = currencies[indexPath.row].0
        tableView.reloadData()
        delegate?.updateCountry(currencies[indexPath.row].1)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.navigationController?.popViewController(animated: false)
        }
    }
}

extension CountryController {
    @objc private func done() {
        navigationController?.popViewController(animated: false)
    }
}
