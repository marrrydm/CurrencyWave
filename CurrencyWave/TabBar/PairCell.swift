import UIKit

class PairCell: UICollectionViewCell {
    var pairLabel = UILabel()
    static let id = "Cell"

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.create()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var isSelected: Bool {
        didSet {
            self.isSelected ? setSelected() : setUnselected()
        }
    }

    func setSelected() {
        self.backgroundColor = UIColor(red: 0.95, green: 0.74, blue: 0.35, alpha: 1)
        pairLabel.textColor = .white
    }

    func setUnselected() {
        pairLabel.textColor = UIColor(red: 0.1, green: 0.11, blue: 0.12, alpha: 1)
        self.backgroundColor = .white
    }


    private func create() {
        labelConfigure()
        self.layer.cornerRadius = 8
        self.backgroundColor = .white
    }

    private func labelConfigure() {
        pairLabel.textColor = UIColor(red: 0.1, green: 0.11, blue: 0.12, alpha: 1)
        pairLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        pairLabel.textAlignment = .center

        pairLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(pairLabel)

        pairLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        pairLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
}
