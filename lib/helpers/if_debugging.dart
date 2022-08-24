import 'package:flutter/foundation.dart';

extension IfDebuggingOnString on String {
  String? get ifDebugging => kDebugMode ? this : null;
}
