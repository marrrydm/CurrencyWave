import TransitionableTab
import UIKit

enum Type: String {
    case move
    case fade
    case scale
    case custom

    static var all: [Type] = [.move, .scale, .fade, .custom]
}

class TabBarController: UITabBarController {
    var type: Type = .move

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self

        tabBar.backgroundColor = UIColor(red: 0.92, green: 0.92, blue: 0.94, alpha: 1)
        tabBar.tintColor = UIColor(red: 0.35, green: 0.34, blue: 0.84, alpha: 1)
        tabBar.unselectedItemTintColor = UIColor(red: 0.56, green: 0.56, blue: 0.58, alpha: 1)
        tabBar.barTintColor = UIColor(red: 0.92, green: 0.92, blue: 0.94, alpha: 1)

        viewControllers = [
            generateVC(
                viewController: UINavigationController(rootViewController: ExchangeController()),
                image: UIImage(named: "Exchange"), title: "Exchange".localize()
            ),
            generateVC(
                viewController:
                    UINavigationController(rootViewController: ConverterController()),
                image: UIImage(named: "Converter"), title: "Converter".localize()
            ),
            generateVC(
                viewController: ChartsController(),
                image: UIImage(named: "Charts"), title: "Charts".localize()
            ),
            generateVC(
                viewController: SettingController(),
                image: UIImage(named: "Settings"), title: "Settings".localize()
            )
        ]
    }

    private func generateVC(viewController: UIViewController, image: UIImage?, title: String?) -> UIViewController {
        viewController.tabBarItem.image = image
        viewController.tabBarItem.title = title
        return viewController
    }
}

extension TabBarController: TransitionableTab {
    func transitionDuration() -> CFTimeInterval {
        return 0.4
    }

    func transitionTimingFunction() -> CAMediaTimingFunction {
        return .easeInOut
    }

    func fromTransitionAnimation(layer: CALayer?, direction: Direction) -> CAAnimation {
        switch type {
        case .move: return DefineAnimation.move(.from, direction: direction)
        case .scale: return DefineAnimation.scale(.from)
        case .fade: return DefineAnimation.fade(.from)
        case .custom:
            let animation = CABasicAnimation(keyPath: "transform.translation.y")
            animation.fromValue = 0
            animation.toValue = -(layer?.frame.height ?? 0)
            return animation
        }
    }

    func toTransitionAnimation(layer: CALayer?, direction: Direction) -> CAAnimation {
        switch type {
        case .move: return DefineAnimation.move(.to, direction: direction)
        case .scale: return DefineAnimation.scale(.to)
        case .fade: return DefineAnimation.fade(.to)
        case .custom:
            let animation = CABasicAnimation(keyPath: "transform.translation.y")
            animation.fromValue = (layer?.frame.height ?? 0)
            animation.toValue = 0
            return animation
        }
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return animateTransition(tabBarController, shouldSelect: viewController)
    }
}
