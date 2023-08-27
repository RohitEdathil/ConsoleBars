![Pub Version (including pre-releases)](https://img.shields.io/pub/v/console_bars?include_prereleases)
![GitHub last commit](https://img.shields.io/github/last-commit/RohitEdathil/ConsoleBars)
![GitHub language count](https://img.shields.io/github/languages/count/RohitEdathil/ConsoleBars)
![GitHub top language](https://img.shields.io/github/languages/top/RohitEdathil/ConsoleBars)

A package for creating an awesome progress bar in the terminal. Handy while developing a CLI or a desktop utility in dart.

### [See in pub.dev](https://pub.dev/packages/console_bars)

## Usage

Options:

- `total` : Total number of steps
- `desc `: Simple text shown before the bar (optional)
- `space` : Character denoting empty space (default : '.')
- `fill `: Character denoting filled space (default : '█')
- `time `: Toggle timing mode (default : false)
- `percentage` : Toggle percentage display (default : false)
- `scale` : Scale of the bar relative to width (between: 0 and 1, default: 0.5, Irrelavant if width is specified)
- `width` : Width of the bar (If not specified, it will be automatically calculated using the terminal width and scale)

Code:

```dart
final p = FillingBar(desc: "Loading", total: 1000, time: true, percentage:true);
  for (var i = 0; i < 1000; i++) {
    p.increment();
    sleep(Duration(milliseconds: 10));
  }
```

Result:

![Animation](https://github.com/RohitEdathil/ConsoleBars/blob/master/img/Animation.gif)

```
Loading : ████████████████████████████████████████.................... 673/1000 67.3% [ 0:00:13.28 / 0:00:06.45 ]
```

**Note:** You can use the `total` and `desc` setters to change the total number of steps and description mid-way.
