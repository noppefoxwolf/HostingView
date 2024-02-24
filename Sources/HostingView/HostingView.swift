import SwiftUI
import UIKit

public final class HostingView<Content: View>: UIView {
    let viewController: UIHostingController<Content>
    
    public init(rootView: Content) {
        viewController = UIHostingController(rootView: rootView)
        super.init(frame: .null)
        addSubview(viewController.view)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewController.view.topAnchor.constraint(equalTo: self.topAnchor),
            self.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor),
            viewController.view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        viewController.willMove(toParent: parent)
    }
    
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        viewController.didMove(toParent: parent)
        if let parent {
            parent.addChild(viewController)
        } else {
            viewController.removeFromParent()
        }
    }
}

extension UIView {
    fileprivate var parent: UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.parent
        } else {
            return nil
        }
    }
}
