# Combine Requests

Helpers for working with requests in Combine.

## Example

```swift
class TodosStore: ObservableRequest {
    public func fetch() {
        URLSession.shared
            .dataTaskPublisher(for: URL(string: "https://jsonplaceholder.typicode.com/todos")!)
            .assignRequest(to: self)
    }
}

struct ExercisesView: View {
    @StateObject private var todos = TodosStore()

    var body: some View {
        List(todos.output ?? []) { todo in
            Text("\(todo.title)")
        }.onAppear(perform: todos.fetch)
    }
}
```
