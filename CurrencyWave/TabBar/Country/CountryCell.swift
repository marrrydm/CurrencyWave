import UIKit

final class CountryCell: UITableViewCell {
    private var countryLabel: UILabel = {
        var view = UILabel()
        view.textColor = .black
        view.font = .systemFont(ofSize: 17, weight: .regular)
        view.textAlignment = .left

        return view
    }()

    private let buttonSelected: UIView = {
        let view = UIView()
        view.backgroundColor = .clear

        return view
    }()

    private let imgPair: UIImageView = {
        let imgPair = UIImageView()
        imgPair.image = UIImage(named: "usa")
        imgPair.contentMode = .scaleAspectFit

        return imgPair
    }()

    private var checkImg: UIImageView = {
        let imgPair = UIImageView()
        imgPair.contentMode = .scaleAspectFit
        imgPair.image = UIImage()

        return imgPair
    }()

    private var arrImgPairs: [(UIImage?, String)] = [
        (UIImage(named: "usa"), "United States, $"),
        (UIImage(named: "united"), "Great Britain, £"),
        (UIImage(named: "australia"), "Australia, $"),
        (UIImage(named: "brazil"), "Brazil, R$"),
        (UIImage(named: "canada"), "Canada, $"),
        (UIImage(named: "china"), "China, ¥"),
        (UIImage(named: "india"), "India, ₹"),
        (UIImage(named: "indonesia"), "Indonesia, Rp"),
        (UIImage(named: "israel"), "Israel, ₪"),
        (UIImage(named: "japan"), "Japan, ¥"),
        (UIImage(named: "mexico"), "Mexico, $"),
        (UIImage(named: "russia"), "Russia, ₽"),
        (UIImage(named: "turkey"), "Turkey, ₺"),
        (UIImage(named: "thb"), "Thailand, ฿")
    ]

    static let id = "Cell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupViews()
        makeConstraints()
        contentView.backgroundColor = .clear
        selectionStyle = .none
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(pair: String, selected: Bool) {
        countryLabel.text = pair
        checkImg.image = selected ? UIImage(named: "check") :  UIImage()
        let forImg = countryLabel.text!
        for item in arrImgPairs {
            if item.1 == forImg {
                imgPair.image = item.0
            }
        }
        buttonSelected.isHidden = !selected
    }

    private func setupViews() {
        contentView.addSubviews(countryLabel, imgPair, buttonSelected, checkImg)
    }

    private func makeConstraints() {
        buttonSelected.translatesAutoresizingMaskIntoConstraints = false
        buttonSelected.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        buttonSelected.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        buttonSelected.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        buttonSelected.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        imgPair.translatesAutoresizingMaskIntoConstraints = false
        imgPair.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imgPair.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        imgPair.heightAnchor.constraint(equalToConstant: 24).isActive = true
        imgPair.widthAnchor.constraint(equalToConstant: 24).isActive = true

        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        countryLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        countryLabel.leadingAnchor.constraint(equalTo: imgPair.trailingAnchor, constant: 16).isActive = true

        checkImg.translatesAutoresizingMaskIntoConstraints = false
        checkImg.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        checkImg.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        checkImg.heightAnchor.constraint(equalToConstant: 14).isActive = true
        checkImg.widthAnchor.constraint(equalToConstant: 14).isActive = true
    }
}
