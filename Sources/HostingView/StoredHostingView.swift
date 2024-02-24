import SwiftUI
import UIKit
import Observation

@dynamicMemberLookup
public final class StoredHostingView<V: View, E: Observable & AnyObject>: UIView {
    let view: UIView
    private var property: E
    
    public init(
        rootView: V,
        _ property: E,
        makeHostingView: (V, E) -> UIView = { HostingView(rootView: $0.environment($1)) }
    ) {
        self.view = makeHostingView(rootView, property)
        self.property = property
        super.init(frame: .null)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor),
            view.leftAnchor.constraint(equalTo: leftAnchor),
            rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public subscript<T>(dynamicMember keyPath: WritableKeyPath<E, T>) -> T {
        get { property[keyPath: keyPath] }
        set { property[keyPath: keyPath] = newValue }
    }
}
