import 'package:junction/config/theme/theme_variant.dart';

import 'custom_theme.dart';

class CustomThemeSettingsModel {
  String activeThemeId;
  String activeThemeVariantId;
  List<CustomTheme> themes;

  CustomThemeSettingsModel(
    this.activeThemeId,
    this.activeThemeVariantId,
    this.themes,
  );

  ThemeVariant? getActiveThemeVariant() {
    for (CustomTheme theme in themes) {
      if (theme.id == activeThemeId) {
        return theme.getActiveVariant(activeThemeVariantId);
      }
    }
    return null;
  }
}
