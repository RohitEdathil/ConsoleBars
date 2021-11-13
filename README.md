![Pub Version (including pre-releases)](https://img.shields.io/pub/v/console_bars?include_prereleases)
![GitHub last commit](https://img.shields.io/github/last-commit/RohitEdathil/ConsoleBars)
![GitHub language count](https://img.shields.io/github/languages/count/RohitEdathil/ConsoleBars)
![GitHub top language](https://img.shields.io/github/languages/top/RohitEdathil/ConsoleBars)

A package for creating an awesome progress bar in console.

## Usage

Options:

- `total` : Total number of steps
- `desc `: Simple text shown before the bar (optional)
- `space` : Character denoting empty space (default : ' ')
- `fill `: Character denoting filled space (default : '█')
- `time `: Toggle timing mode (default : false)
- `percentage` : Toggle percentage display (default : false)
- `scale` : Width of the bar (between: 0 and 1, default: 0.5)

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
