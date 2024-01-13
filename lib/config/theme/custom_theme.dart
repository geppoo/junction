import 'package:junction/config/theme/theme_variant.dart';

class CustomTheme {
  String id;
  List<ThemeVariant> variants;

  CustomTheme(
    this.id,
    this.variants,
  );

  ThemeVariant? getActiveVariant(String variantId){
    for (ThemeVariant variant in variants){
      if (variant.variantId == variantId){
        return variant;
      }
    }
    return null;
  }
}
