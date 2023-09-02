import UIKit

protocol CurrencyDelegate: AnyObject {
    func updateCurrency(_ value: [String]?)
}

protocol CurrencyDelegate2: AnyObject {
    func updateCurrency2(_ value: [String: Double]?)
}

class CurrencyController: UIViewController {
    private let titleLabel: UILabel = {
        let labelTitle = UILabel()
        labelTitle.textColor = .black
        labelTitle.text = "Change currency".localize()
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
        btn.addTarget(self, action: #selector(pop), for: .touchUpInside)

        return btn
    }()

    private lazy var imgView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "left")
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(done)))

        return view
    }()

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.isUserInteractionEnabled = true
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.allowsMultipleSelection = true
        tableView.separatorStyle = .none
        tableView.register(CurrencyCell.self, forCellReuseIdentifier: CurrencyCell.id)
        tableView.setEditing(false, animated: true)
        tableView.separatorStyle = .singleLine
        tableView.separatorInset.right = 0
        tableView.separatorInset.left = 56
        tableView.separatorColor = UIColor(red: 0.165, green: 0.169, blue: 0.196, alpha: 1)

        return tableView
    }()

    var currency: String?
    private var arrCurrency = [Int]()
    private var boolCheck = [false, false, false, false, false, false, false, false, false, false, false, false, false, false]

    private let currencies1: [(UIImage?, String, String, Double, Int)] = [
        (UIImage(named: "usa"), "United States Dollar (USD)", "USD", 1.0, 0),
        (UIImage(named: "eur"), "Euro (EUR)", "EUR", 1.0917, 1),
        (UIImage(named: "united"), "British Pound Sterling (GBP)", "GBP", 1.2716, 2),
        (UIImage(named: "australia"), "Australian Dollar (AUD)", "AUD", 0.64, 3),
        (UIImage(named: "brazil"), "Brazilian Real (BRL)", "BRL", 0.2011, 4),
        (UIImage(named: "canada"), "Canadian Dollar (CAD)", "CAD", 0.7379, 5),
        (UIImage(named: "china"), "Chinese Yuan (CNY)", "CNY", 0.1366, 6),
        (UIImage(named: "india"), "Indian Rupee (INR)", "INR", 0.0121, 7),
        (UIImage(named: "japan"), "Japanese Yen (JPY)", "JPY", 0.0069, 8),
        (UIImage(named: "russia"), "Russian Ruble (RUB)", "RUB", 0.0106, 9),
        (UIImage(named: "switzerland"), "Swiss Franc (CHF)", "CHF", 1.1393, 10),
        (UIImage(named: "new-zealand"), "New Zealand Dollar", "NZD", 0.59, 11),
        (UIImage(named: "turkey"), "Turkey", "TRY", 0.0368, 12),
        (UIImage(named: "thb"), "Thailand", "THB", 0.0285, 13)
    ]

    private var currencies = [(UIImage?, String, String, Double, Int)]()
    
    weak var delegate: CurrencyDelegate?
    weak var delegate2: CurrencyDelegate2?
    var num: Int?
    var currenciesLast = [String]()
    private var step = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1)
        navigationController?.navigationBar.isHidden = true

        for var item in currencies1 {
            for i in UserData.percent {
                if i.key == item.2 {
                    item.3 = i.value
                    currencies.append(item)
                }
            }
        }

        for i in currencies {
            for j in currenciesLast {
                if i.2 == j {
                    boolCheck[i.4] = true
                    arrCurrency.append(i.4)
                }
            }
        }

        setupViews()
        makeConstraints()

        tableView.delegate = self
        tableView.dataSource = self
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
        imgView.widthAnchor.constraint(equalToConstant: 18).isActive = true

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        tableView.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 35).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

extension CurrencyController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currencies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CurrencyCell.id
        ) as? CurrencyCell else {
            fatalError("failed to get value cell")
        }

        cell.configure(pair: currencies[indexPath.row].1, selected: boolCheck[indexPath.row])

        if indexPath.row == 0 {
            cell.layer.cornerRadius = 14
            cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            cell.layer.masksToBounds = true
            cell.clipsToBounds = true
        }

        if indexPath.row == (currencies.count - 1) {
            currenciesLast = []
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

extension CurrencyController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currency = currencies[indexPath.row].1
        guard let paths = tableView.indexPathsForSelectedRows else { return }
        for path in paths {
            if boolCheck[path.row] == true {
                boolCheck[path.row] = false
                arrCurrency = arrCurrency.filter{$0 != path.row}
            } else {
                boolCheck[path.row] = true
                arrCurrency.append(path.row)
            }
        }
        tableView.reloadData()
    }
}

extension CurrencyController {
    @objc private func pop() {
        var result = [String]()
        var result2 = [String: Double]()

        for item in arrCurrency {
            result.append(currencies[item].2)
            result2.updateValue(currencies[item].3, forKey: currencies[item].2)
        }

        if num == 0 {
            delegate?.updateCurrency(result)
            UserDefaults.standard.set(result, forKey: UserData.SettingsKeys.stringExchange.rawValue)
        } else {
            delegate2?.updateCurrency2(result2)
            UserDefaults.standard.set(result2, forKey: UserData.SettingsKeys.stringConverter.rawValue)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.navigationController?.popViewController(animated: false)
            UserDefaults.standard.set(result, forKey: UserData.SettingsKeys.stringExchange.rawValue)
            UserDefaults.standard.set(result2, forKey: UserData.SettingsKeys.stringConverter.rawValue)
        }
    }
}

extension CurrencyController {
    @objc private func done() {
        navigationController?.popViewController(animated: false)
    }
}
