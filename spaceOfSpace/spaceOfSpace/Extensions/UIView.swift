import UIKit

extension UIView {
    func useConstraints(addToView view: UIView? = nil) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        if let view = view {
            view.addSubview(self)
        }
        return self
    }
    
    public var viewWidth: CGFloat {
        return self.frame.size.width
    }
    
    public var viewHeight: CGFloat {
        return self.frame.size.height
    }
}
