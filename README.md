A package for creating awesome progress bars and loading animations in console.

## Getting started

```
pub add console_bars
```

## Available Progress Bars

- ### FillingBar
  Code:

```dart
final p = FillingBar(desc: "Loading", total: 1000, time: true);
  for (var i = 0; i < 1000; i++) {
    p.increment();
    sleep(Duration(milliseconds: 10));
  }
```

Result:

```
Loading : ████████████████████████████████████████.................... 673/1000 [ 0:00:13.28 / 0:00:06.45 ]
```

More coming soon :)
