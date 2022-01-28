import Foundation
import UIKit

class NotchViewController: VerticalViewController {
    
    var handleView:UIView = {
        var handleView = UIView()
        handleView.backgroundColor = UIColor.white
        handleView.translatesAutoresizingMaskIntoConstraints = false
        handleView.layer.cornerRadius = 2.0
        return handleView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
        self.view.addSubview(handleView)
        
        NSLayoutConstraint.activate([
            self.handleView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.handleView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.handleView.heightAnchor.constraint(equalToConstant: 5),
            self.handleView.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
}
