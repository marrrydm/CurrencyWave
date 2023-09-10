import UIKit

final class ConverterCell: UICollectionViewCell {
    var currencyLabel: UILabel = {
        var view = UILabel()
        view.textColor = .black
        view.font = .systemFont(ofSize: 17, weight: .semibold)
        view.textAlignment = .left

        return view
    }()

    private let img: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "AUD")
        view.contentMode = .scaleAspectFit

        return view
    }()

    var valueLabel: UILabel = {
        var view = UILabel()
        view.textColor = .black
        view.font = .systemFont(ofSize: 17, weight: .semibold)
        view.textAlignment = .right

        return view
    }()

    lazy var textField: UITextField = {
        let view = UITextField()
        view.placeholder = "0"
        view.textAlignment = .right
        view.keyboardType = .numberPad
        view.textColor = .black
        view.font = .systemFont(ofSize: 17, weight: .semibold)
        view.isUserInteractionEnabled = false

        return view
    }()

    private var arrImgCurrency: [(UIImage?, String, String)] = [
        (UIImage(named: "usa"), "USD", "$"),
        (UIImage(named: "eur"), "EUR", "€"),
        (UIImage(named: "united"), "GBP", "£"),
        (UIImage(named: "australia"), "AUD", "$"),
        (UIImage(named: "brazil"), "BRL", "R$"),
        (UIImage(named: "canada"), "CAD", "$"),
        (UIImage(named: "china"), "CNY", "¥"),
        (UIImage(named: "india"), "INR", "₹"),
        (UIImage(named: "japan"), "JPY", "¥"),
        (UIImage(named: "russia"), "RUB", "₽"),
        (UIImage(named: "switzerland"), "CHF", "₣"),
        (UIImage(named: "new-zealand"), "NZD", "$"),
        (UIImage(named: "turkey"), "TRY", "₺"),
        (UIImage(named: "israel"), "ILS", "₪"),
        (UIImage(named: "thb"), "THB", "฿")
    ]

    static let id = "Cell"

    func setup(data: String) {
        currencyLabel.text = data

        for item in arrImgCurrency {
            if item.1 == data {
                img.image = item.0
                valueLabel.text = item.2
            }
        }

        self.backgroundColor = .white
        self.layer.cornerRadius = 14

        setupViews()
        makeConstraints()
    }

    private func setupViews() {
        contentView.addSubviews(img, currencyLabel, valueLabel, textField)
    }

    private func makeConstraints() {
        img.translatesAutoresizingMaskIntoConstraints = false
        img.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        img.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        img.widthAnchor.constraint(equalToConstant: 24).isActive = true
        img.heightAnchor.constraint(equalToConstant: 24).isActive = true

        currencyLabel.translatesAutoresizingMaskIntoConstraints = false
        currencyLabel.leadingAnchor.constraint(equalTo: img.trailingAnchor, constant: 8).isActive = true
        currencyLabel.centerYAnchor.constraint(equalTo: img.centerYAnchor).isActive = true

        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        valueLabel.widthAnchor.constraint(equalToConstant: 22).isActive = true
        valueLabel.centerYAnchor.constraint(equalTo: img.centerYAnchor).isActive = true

        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.trailingAnchor.constraint(equalTo: valueLabel.leadingAnchor, constant: -5).isActive = true
        textField.leadingAnchor.constraint(equalTo: currencyLabel.trailingAnchor, constant: 30).isActive = true
        textField.centerYAnchor.constraint(equalTo: img.centerYAnchor).isActive = true
    }
}
