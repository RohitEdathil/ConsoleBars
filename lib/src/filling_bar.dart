import 'dart:async';
import 'dart:io';

/// A normal bar that fills up when value is updated
///
/// Looks like this:
///
/// Loading : ████████████████████████████████████████.................... 673/1000 67.3% [ 0:00:13.28 / 0:00:06.45 ]

class FillingBar {
  /// Total number of steps
  int _total;

  int _current = 0;
  int _progress = 0;
  late int max;

  // Time
  final _clock = Stopwatch();

  /// Whether a timer should be present
  bool time;

  /// Percentage should be displayed or not
  bool percentage;

  // Decorations

  /// The description of the bar
  String _desc;

  /// The chararcter to used as space
  String space;

  /// The character to used as fill
  String fill;

  /// Scale of the bar relative to the terminal width
  double scale;

  /// Width of the bar
  int? width;

  int get total => _total;
  String get desc => _desc;

  set desc(String desc) {
    _desc = desc;
    _render();
  }

  set total(int total) {
    _total = total;
    _render();
  }

  /// Arguments:
  /// - total : Total number of steps
  /// - desc : Simple text shown before the bar (optional)
  /// - space : Character denoting empty space (default : '.')
  /// - fill : Character denoting filled space (default : '█')
  /// - time : Toggle timing mode (default : false)
  /// - percentage : Toggle percentage display (default : false)
  /// - scale : Scale of the bar relative to width (between: 0 and 1, default: 0.5, Irrelavant if width is specified)
  /// - width : Width of the bar (If not specified, it will be automatically calculated using the terminal width and scale)
  FillingBar(
      {required int total,
      String desc = "",
      this.space = ".",
      this.fill = "█",
      this.time = false,
      this.percentage = false,
      this.scale = 0.5,
      this.width})
      : _desc = desc,
        _total = total {
    // Handles width of the bar, throws an error if it's not specified and the terminal width is not available
    try {
      max = width ?? ((stdout.terminalColumns - _desc.length) * scale).toInt();
    } on StdoutException {
      throw StdoutException(
          "Could not get terminal width, try specifying a width manually");
    }
    if (time) {
      _clock.start();
      scheduleMicrotask(autoRender);
    }
    _render();
  }

  /// Updates the _current value to n
  void update(int n) {
    _current = n;
    _render();
  }

  /// Increments the _current value
  void increment() {
    _current++;
    _render();
  }

  /// Automatically updates the frame asynchronously
  void autoRender() async {
    while (_clock.isRunning) {
      await Future.delayed(Duration(seconds: 1));
      _render();
    }
  }

  /// Renders a frame of the bar
  void _render() {
    _progress = ((_current / _total) * max).toInt();
    if (_progress >= max) {
      _progress = max;
      if (_clock.isRunning) {
        _clock.stop();
      }
    }
    String timeStr = "";
    if (time) {
      final rate = _clock.elapsedMicroseconds / (_current == 0 ? 1 : _current);
      final eta = Duration(microseconds: ((_total - _current) * rate).toInt());
      timeStr = "[ " +
          _clock.elapsed.toString().substring(0, 10) +
          " / " +
          eta.toString().substring(0, 10) +
          " ]";
    }
    String perc = '';
    if (percentage) {
      perc = "${(_current * 100 / _total).toStringAsFixed(1)}%";
    }
    final frame =
        "$_desc : ${fill * _progress}${space * (max - _progress)} $_current/$_total $perc $timeStr";
    stdout.write("\r");
    stdout.write(frame);
  }
}
