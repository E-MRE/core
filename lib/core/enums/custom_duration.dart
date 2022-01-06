///It was created to use specific Duration values for seconds.
///
/// * [zero]: 0
/// * [extraFast]: 1
/// * [veryFast]: 2
/// * [fast]: 4
/// * [normal]: 8
/// * [slow]: 16
/// * [verySlow]: 32
/// * [extraSlow]: 64
enum CustomDuration {
  /// `value = 0 `
  zero,

  /// `value = 1 `
  extraFast,

  /// `value = 2 `
  veryFast,

  /// `value = 4 `
  fast,

  /// `value = 8 `
  normal,

  /// `value = 16 `
  slow,

  /// `value = 32 `
  verySlow,

  /// `value = 64 `
  extraSlow,
}

extension DurationsExtension on CustomDuration {
  Duration rawValue() {
    switch (this) {
      case CustomDuration.zero:
        return const Duration(seconds: 0);
      case CustomDuration.extraFast:
        return const Duration(seconds: 1);
      case CustomDuration.veryFast:
        return const Duration(seconds: 2);
      case CustomDuration.fast:
        return const Duration(seconds: 4);
      case CustomDuration.normal:
        return const Duration(seconds: 8);
      case CustomDuration.slow:
        return const Duration(seconds: 16);
      case CustomDuration.verySlow:
        return const Duration(seconds: 32);
      case CustomDuration.extraSlow:
        return const Duration(seconds: 64);
    }
  }
}
