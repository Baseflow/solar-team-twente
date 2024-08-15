/// All the constants variables with the default space values.
///
/// These values can be used for paddings, margins and heights and width for
/// `SizedBox` elements.
///
/// Generally speaking no other values should every be used as paddings or
/// margins. Only using these values will cause good consistency in code and
/// look and feel in the app.
///
/// Using these constants will make it easier to find and change uses of these
/// values when for example Google's Material Design or our
/// own design system changes.
class Sizes {
  /// 0 spacing.
  static const double zero = 0;

  /// 2 spacing.
  static const double s2 = 2;

  /// 4 spacing.
  static const double s4 = 4;

  /// 8 spacing.
  static const double s8 = 8;

  /// 12 spacing.
  static const double s12 = 12;

  /// 16 spacing.
  static const double s16 = 16;

  /// 24 spacing.
  static const double s24 = 24;

  /// 32 spacing.
  static const double s32 = 32;

  /// 48 spacing.
  static const double s48 = 48;

  /// 56 spacing.
  static const double s56 = 56;

  /// 64 spacing.
  static const double s64 = 64;

  /// 96 spacing.
  static const double s96 = 96;

  /// 128 spacing.
  static const double s128 = 128;

  /// 256 spacing.
  static const double s256 = 256;

  /// 384 spacing.
  static const double s384 = s256 + s128;

  /// 512 spacing.
  static const double s512 = 512;

  /// 1024 spacing.
  static const double s1024 = 1024;

  /// The height of the carousel bottom sheet.
  static const double carouselBottomSheetHeight = 200;

  /// The default bottom sheet corner radius, as determined by Material 3.
  static const double defaultBottomSheetCornerRadius = 28;
}
