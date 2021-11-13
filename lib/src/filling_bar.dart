import 'dart:async';
import 'dart:io';

/// A normal bar that fills up when value is updated
///
/// Looks like this:
///
/// Loading : ████████████████████████████████████████.................... 673/1000 67.3% [ 0:00:13.28 / 0:00:06.45 ]

class FillingBar {
  // Counts
  final int total;
  int current = 0;
  int progress = 0;
  late int max;

  // Time
  final clock = Stopwatch();
  bool time;

  // Percentage
  bool percentage;
  // Decorations
  final String desc;
  String space;
  String fill;
  double scale;

  /// Arguments:
  /// - total : Total number of steps
  /// - desc : Simple text shown before the bar (optional)
  /// - space : Character denoting empty space (default : ' ')
  /// - fill : Character denoting filled space (default : '█')
  /// - time : Toggle timing mode (default : false)
  /// - percentage : Toggle percentage display (default : false)
  /// - scale : Width of the bar (between: 0 and 1, default: 0.5)
  FillingBar({
    required this.total,
    this.desc = "",
    this.space = ".",
    this.fill = "█",
    this.time = false,
    this.percentage = false,
    this.scale = 0.5,
  }) {
    max = ((stdout.terminalColumns - desc.length) * scale).toInt();
    if (time) {
      clock.start();
      scheduleMicrotask(autoRender);
    }
    _render();
  }

  /// Updates the current value to n
  void update(int n) {
    current = n;
    _render();
  }

  /// Increments the current value
  void increment() {
    current++;
    _render();
  }

  // Automatically updates the frame asynchronously
  void autoRender() async {
    while (clock.isRunning) {
      sleep(Duration(seconds: 1));
      _render();
    }
  }

  /// Renders a frame of the bar
  void _render() {
    progress = ((current / total) * max).toInt();
    if (progress >= max) {
      progress = max;
      if (clock.isRunning) {
        clock.stop();
      }
    }
    String timeStr = "";
    if (time) {
      final rate = clock.elapsedMicroseconds / (current == 0 ? 1 : current);
      final eta = Duration(microseconds: ((total - current) * rate).toInt());
      timeStr = "[ " +
          clock.elapsed.toString().substring(0, 10) +
          " / " +
          eta.toString().substring(0, 10) +
          " ]";
    }
    String perc = '';
    if (percentage) {
      perc = "${current * 100 / total}%";
    }
    final frame =
        "$desc : ${fill * progress}${space * (max - progress)} $current/$total $perc $timeStr";
    stdout.write("\r");
    stdout.write(frame);
  }
}
