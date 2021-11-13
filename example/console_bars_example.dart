import 'dart:io';

import 'package:console_bars/console_bars.dart';

void main(List<String> args) {
  // A bar that looks like
  //
  // Loading : ████████████████████████████████████████.................... 673/1000 67.3% [ 0:00:13.28 / 0:00:06.45 ]
  //
  final p =
      FillingBar(desc: "Loading", total: 1000, time: true, percentage: true);
  for (var i = 0; i < 1000; i++) {
    p.increment();
    sleep(Duration(milliseconds: 10));
  }
}
