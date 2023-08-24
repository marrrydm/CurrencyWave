import UIKit

class ConverterController: UIViewController, UIScrollViewDelegate {
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.text = "Currency Converter".localize()
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
        view.register(ConverterCell.self, forCellWithReuseIdentifier: "ConverterCell")
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false

        return view
    }()

    private var convert = [(String, Double, String, UIImage?, String)]()
    private var convert1: [(String, Double, String, UIImage?, String)] = [
        ("USD", 1.0, "$", UIImage(named: "usa"), "usa"),
        ("GBP", 1.2716, "£", UIImage(named: "united"), "united"),
        ("AUD", 0.64, "$", UIImage(named: "australia"), "australia"),
        ("BRL", 0.2011, "R$", UIImage(named: "brazil"), "brazil"),
        ("CAD", 0.7379, "$", UIImage(named: "canada"), "canada"),
        ("CNY", 0.1366, "¥", UIImage(named: "china"), "china"),
        ("INR", 0.0121, "₹", UIImage(named: "india"), "india"),
        ("IDR", 0.000065, "Rp", UIImage(named: "indonesia"), "indonesia"),
        ("ILS", 0.26, "₪", UIImage(named: "israel"), "israel"),
        ("JPY", 0.0069, "¥", UIImage(named: "japan"), "japan"),
        ("MXN", 0.059, "$", UIImage(named: "mexico"), "mexico"),
        ("RUB", 0.0106, "₽", UIImage(named: "russia"), "russia"),
        ("TRY", 0.037, "₺", UIImage(named: "turkey"), "turkey"),
        ("CHF", 1.1393, "₣", UIImage(named: "switzerland"), "switzerland"),
        ("NZD", 0.59, "₽", UIImage(named: "new-zealand"), "new-zealand"),
        ("EUR", 1.0917, "€", UIImage(named: "eur"), "eur")
    ]

    private var currencies = [String: Double]()
    private var currenciesArrayKeys = Array(UserData.stringConverter.keys)
    private let currensiesUD = Array(UserData.currenciesNew)
    private var percent = 0.0106
    private var sign = "₽"
    private var changedCurrensies = [(String, Double)]()
    private var editCurrency: String = ""
    private var arrTxtField = [String: Double]()
    private var isBool = false

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imgView.image = UIImage(named: UserData.country)
        arrTxtField = [:]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1)
        navigationController?.navigationBar.isHidden = true

        for var item in convert1 {
            for i in UserData.percent {
                if i.key == item.0 {
                    item.1 = i.value
                    convert.append(item)
                }
            }
        }

        for item in convert {
            if item.4 == UserData.country {
                percent = item.1
                sign = item.2
            }
        }

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

extension ConverterController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        isBool = true
        arrTxtField = [:]
        var perc = 0.0
        let txtFld = Double(textField.text!)!
        
        for i in convert {
            if i.0 == editCurrency {
                perc = i.1
            }
        }

        for i in currencies {
            let result = ( 1 / ((i.value) / perc)) * txtFld
            arrTxtField.updateValue(result, forKey: i.key)
        }
        collectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        currencies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ConverterCell", for: indexPath) as! ConverterCell
        cell.setup(data: currenciesArrayKeys[indexPath.row])
        cell.textField.delegate = self
        addDoneButtonOnKeyboard(textField: cell.textField)

        var value = 0.0
        for (_, item) in currensiesUD.enumerated() {
            if item.key == currenciesArrayKeys[indexPath.row] {
                value = item.value
                changedCurrensies.append((item.key, value))
            }
        }

        cell.textField.isUserInteractionEnabled = false

        if isBool {
            for i in arrTxtField {
                if i.key == currenciesArrayKeys[indexPath.row] {
                    cell.textField.text = "\((Double(round(10000 * i.value) / 10000)))"
                }
            }
        } else {
            cell.textField.text = "0"
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        editCurrency = currenciesArrayKeys[indexPath.row]
        let cell: ConverterCell = collectionView.cellForItem(at: indexPath) as! ConverterCell

        cell.textField.isUserInteractionEnabled = false
        cell.textField.isUserInteractionEnabled = true
        self.becomeFirstResponder()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (collectionView.frame.width), height: 56)
    }
}

extension ConverterController {
    func addDoneButtonOnKeyboard(textField: UITextField) {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        textField.inputAccessoryView = doneToolbar
    }


    @objc func doneButtonAction() {
        self.resignFirstResponder()
        self.view.endEditing(true)
    }
}

extension ConverterController {
    @objc private func pushVC() {
        let vc = CurrencyController()
        vc.num = 1
        vc.delegate2 = self
        navigationController?.pushViewController(vc, animated: false)
    }

    @objc private func pushCountry() {
        let vc = CountryController()
        vc.num = 1
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: false)
    }
}

extension ConverterController: CountryDelegate {
    func updateCountry(_ value: String?) {
        for item in convert {
            if item.0 == value {
                percent = item.1
                sign = item.2
                imgView.image = item.3

                UserDefaults.standard.set(item.4, forKey: UserData.SettingsKeys.country.rawValue)
            }
        }
        collectionView.reloadData()
    }
}

extension ConverterController: CurrencyDelegate2 {
    func updateCurrency2(_ value: [String: Double]?) {
        currencies = value ?? [:]
        UserDefaults.standard.set(currencies, forKey: UserData.SettingsKeys.stringConverter.rawValue)
        currenciesArrayKeys = Array(UserData.stringConverter.keys)
        collectionView.reloadData()
    }
}
