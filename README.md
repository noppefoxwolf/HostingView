# HostingView

# Usage

## HostingView

```swift
let view = HostingView(rootView: Text("Hello, World!"))
```

## StoredHostingView

```swift
let countLabel = StoredHostingView(rootView: CounterView(), CounterView.Model())
countLabel.count += 1
```

```swift
struct CounterView: View {
    @Observable
    class Model {
        var count = 0
    }
    
    @Environment(Model.self)
    var model
    
    var body: some View {
        Text(model.count.formatted())
    }
}
```

# License

HostingView is available under the MIT license. See the LICENSE file for more info.
