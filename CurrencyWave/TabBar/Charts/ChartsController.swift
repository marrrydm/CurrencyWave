import UIKit
import WebKit

final class ChartsController: UIViewController, UIScrollViewDelegate {
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.text = "Charts".localize()
        view.font = .systemFont(ofSize: 34, weight: .bold)
        view.textAlignment = .left

        return view
    }()

    private lazy var currencyView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.93, green: 0.94, blue: 0.95, alpha: 1)
        view.layer.cornerRadius = 14
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(currencyAction)))

        return view
    }()

    private let currencyTitleLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .left
        view.textColor = UIColor(red: 0.53, green: 0.53, blue: 0.55, alpha: 1)
        view.font = .systemFont(ofSize: 15, weight: .regular)
        view.text = "Currency pair".localize()

        return view
    }()

    private let currencyLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .left
        view.textColor = UIColor(red: 0.1, green: 0.11, blue: 0.12, alpha: 1)
        view.font = .systemFont(ofSize: 17, weight: .semibold)
        view.text = "USD/CAD"

        return view
    }()

    private let bottomImg: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "bottom")
        view.contentMode = .scaleAspectFit

        return view
    }()

    private lazy var chartView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.98, alpha: 1)
        return view
    }()

    private lazy var chart = WKWebView()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 10, right: 20)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PairCell.self, forCellWithReuseIdentifier: PairCell.id)
        collectionView.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.98, alpha: 1)
        collectionView.layer.cornerRadius = 10
        collectionView.layer.masksToBounds = true
        collectionView.allowsMultipleSelection = false

        return collectionView
    }()

    private var cells: [String] = []
    private var data = ""
    private var isSwitch = false

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let content = TradingView(width: chart.frame.width - 20.0, height: chart.frame.height, symbol: "USDCAD").getHTMLContent()
        chart.loadHTMLString(content, baseURL: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 0.98, alpha: 1)
        navigationController?.navigationBar.isHidden = true

        view.addSubviews(titleLabel, currencyView, chart, chartView, collectionView)
        currencyView.addSubviews(currencyLabel, currencyTitleLabel, bottomImg)
        collectionView.isHidden = true

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true

        currencyView.translatesAutoresizingMaskIntoConstraints = false
        currencyView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
        currencyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        currencyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        currencyView.heightAnchor.constraint(equalToConstant: 60).isActive = true

        currencyTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        currencyTitleLabel.bottomAnchor.constraint(equalTo: currencyView.centerYAnchor, constant: -3).isActive = true
        currencyTitleLabel.leadingAnchor.constraint(equalTo: currencyView.leadingAnchor, constant: 16).isActive = true

        currencyLabel.translatesAutoresizingMaskIntoConstraints = false
        currencyLabel.topAnchor.constraint(equalTo: currencyView.centerYAnchor, constant: 3).isActive = true
        currencyLabel.leadingAnchor.constraint(equalTo: currencyView.leadingAnchor, constant: 16).isActive = true

        bottomImg.translatesAutoresizingMaskIntoConstraints = false
        bottomImg.centerYAnchor.constraint(equalTo: currencyLabel.centerYAnchor).isActive = true
        bottomImg.leadingAnchor.constraint(equalTo: currencyLabel.trailingAnchor, constant: 9).isActive = true
        bottomImg.heightAnchor.constraint(equalToConstant: 20).isActive = true
        bottomImg.widthAnchor.constraint(equalToConstant: 20).isActive = true

        chart.translatesAutoresizingMaskIntoConstraints = false
        chart.topAnchor.constraint(equalTo: currencyView.bottomAnchor, constant: 16).isActive = true
        chart.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70).isActive = true
        chart.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        chart.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        chartView.bottomAnchor.constraint(equalTo: chart.bottomAnchor).isActive = true
        chartView.leadingAnchor.constraint(equalTo: chart.leadingAnchor).isActive = true
        chartView.trailingAnchor.constraint(equalTo: chart.trailingAnchor).isActive = true

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: currencyView.bottomAnchor, constant: 16).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -1).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        cells = Array(UserData.pairs.keys)

        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension ChartsController {
    @objc private func currencyAction() {
        if !isSwitch {
            collectionView.isHidden = false
            bottomImg.image = UIImage(named: "up")
            isSwitch = !isSwitch
        } else {
            collectionView.isHidden = true
            bottomImg.image = UIImage(named: "bottom")
            isSwitch = !isSwitch
        }
    }
}

extension ChartsController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PairCell.id, for: indexPath) as! PairCell
        cell.pairLabel.text = cells[indexPath.row].prefix(3) + "/" + cells[indexPath.row].suffix(3)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? PairCell
        data = (cell?.pairLabel.text ?? "") 

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            let content = TradingView(width: chart.frame.width - 20.0, height: chart.frame.height, symbol: "\(data.prefix(3) + data.suffix(3))").getHTMLContent()
            chart.loadHTMLString(content, baseURL: nil)

            currencyLabel.text = "\(data.prefix(3) + "/" + data.suffix(3))"

            bottomImg.image = UIImage(named: "bottom")
            collectionView.isHidden = true
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (view.frame.width - 56) / 2
        return CGSize(width: itemWidth, height: 51)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
}
