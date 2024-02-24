import SwiftUI
import HostingView

@main
struct App: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        ViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

struct CounterView: View {
    @Observable
    class Model {
        var count = 0
    }
    
    @Environment(Model.self)
    var model
    
    var body: some View {
        Text(model.count.formatted())
            .font(.title)
            .bold()
    }
}

struct ClearButton: View {
    @Observable
    class Model {
        var onTap: () -> Void = {}
    }
    
    @Environment(Model.self)
    var model
    
    var body: some View {
        Button(action: model.onTap, label: {
            Text("Clear")
        })
    }
}

class ViewController: UIViewController {
    let countLabel = StoredHostingView(rootView: CounterView(), CounterView.Model())
    let button: UIButton = UIButton(configuration: .filled())
    let clearButton = StoredHostingView(rootView: ClearButton(), ClearButton.Model())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        button.configuration?.title = "Add"
        
        let stackView = UIStackView(
            arrangedSubviews: [
                countLabel,
                button,
                clearButton
            ]
        )
        stackView.axis = .vertical
        stackView.spacing = 10
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
            ),
            stackView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 20
            ),
            view.trailingAnchor.constraint(
                equalTo: stackView.safeAreaLayoutGuide.trailingAnchor,
                constant: 20
            ),
        ])
        
        button.addAction(UIAction { [unowned self] _ in
            countLabel.count += 1
        }, for: .primaryActionTriggered)
        
        clearButton.onTap = { [unowned self] in
            countLabel.count = 0
        }
    }
}
