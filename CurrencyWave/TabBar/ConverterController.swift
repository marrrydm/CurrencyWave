import UIKit

class ConverterController: UIViewController, UIScrollViewDelegate {
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.text = "Fibonacci Levels".localize()
        view.font = .systemFont(ofSize: 34, weight: .bold)
        view.textAlignment = .left

        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1)
        navigationController?.navigationBar.isHidden = true
    }
}
