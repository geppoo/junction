import 'dart:ui';

class ThemeVariant {
  String variantId;
  Color primary;
  Color onPrimary;
  Color secondary;
  Color onSecondary;

  ThemeVariant(
    this.variantId,
    this.primary,
    this.onPrimary,
    this.secondary,
    this.onSecondary,
  );
}
