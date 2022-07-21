import 'dart:math' as math show Random;

extension RandomItem<T> on Iterable<T> {
  T getRandomItem() {
    return elementAt(
      math.Random().nextInt(length),
    );
  }
}
