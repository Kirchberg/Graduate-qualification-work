import UIKit

class VerticalViewController: UIViewController {
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}

class VerticalNavigationController: UINavigationController{
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
