# Combine Requests

Helpers for working with requests in Combine.

## Example

```swift
URLSession.shared
    .dataTaskPublisher(for: URL(string: "https://jsonplaceholder.typicode.com/users")!)
    .request()
    .assign(outputTo: \.output, on: self)
```
