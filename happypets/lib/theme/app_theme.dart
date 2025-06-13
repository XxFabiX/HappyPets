import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff9e4300),
      surfaceTint: Color(0xff9e4300),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xfff68544),
      onPrimaryContainer: Color(0xff632800),
      secondary: Color(0xff845237),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xfffdba99),
      onSecondaryContainer: Color(0xff78482e),
      tertiary: Color(0xff5f6300),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffa4aa21),
      onTertiaryContainer: Color(0xff3a3c00),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffff8f6),
      onSurface: Color(0xff231914),
      onSurfaceVariant: Color(0xff564339),
      outline: Color(0xff897267),
      outlineVariant: Color(0xffddc1b4),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff392e28),
      inversePrimary: Color(0xffffb691),
      primaryFixed: Color(0xffffdbcb),
      onPrimaryFixed: Color(0xff341100),
      primaryFixedDim: Color(0xffffb691),
      onPrimaryFixedVariant: Color(0xff783100),
      secondaryFixed: Color(0xffffdbcb),
      onSecondaryFixed: Color(0xff331100),
      secondaryFixedDim: Color(0xfffab896),
      onSecondaryFixedVariant: Color(0xff693b22),
      tertiaryFixed: Color(0xffe4ea5e),
      onTertiaryFixed: Color(0xff1c1d00),
      tertiaryFixedDim: Color(0xffc7ce45),
      onTertiaryFixedVariant: Color(0xff474a00),
      surfaceDim: Color(0xffe9d6ce),
      surfaceBright: Color(0xfffff8f6),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff1eb),
      surfaceContainer: Color(0xfffeeae1),
      surfaceContainerHigh: Color(0xfff8e4dc),
      surfaceContainerHighest: Color(0xfff2dfd6),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff5e2500),
      surfaceTint: Color(0xff9e4300),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffb15111),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff552b13),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff956044),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff363900),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff6d7200),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f6),
      onSurface: Color(0xff180f0b),
      onSurfaceVariant: Color(0xff443229),
      outline: Color(0xff634e44),
      outlineVariant: Color(0xff7f685e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff392e28),
      inversePrimary: Color(0xffffb691),
      primaryFixed: Color(0xffb15111),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff8e3c00),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff956044),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff79492f),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff6d7200),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff555900),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd5c3bb),
      surfaceBright: Color(0xfffff8f6),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff1eb),
      surfaceContainer: Color(0xfff8e4dc),
      surfaceContainerHigh: Color(0xffecd9d1),
      surfaceContainerHighest: Color(0xffe1cec6),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff4e1d00),
      surfaceTint: Color(0xff9e4300),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff7c3300),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff48210a),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff6b3d24),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff2c2e00),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff494d00),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f6),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff392820),
      outlineVariant: Color(0xff59453b),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff392e28),
      inversePrimary: Color(0xffffb691),
      primaryFixed: Color(0xff7c3300),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff582200),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff6b3d24),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff502810),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff494d00),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff333500),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc7b5ad),
      surfaceBright: Color(0xfffff8f6),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffffede6),
      surfaceContainer: Color(0xfff2dfd6),
      surfaceContainerHigh: Color(0xffe4d1c8),
      surfaceContainerHighest: Color(0xffd5c3bb),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffb691),
      surfaceTint: Color(0xffffb691),
      onPrimary: Color(0xff552100),
      primaryContainer: Color(0xfff68544),
      onPrimaryContainer: Color(0xff632800),
      secondary: Color(0xfffab896),
      onSecondary: Color(0xff4e260e),
      secondaryContainer: Color(0xff693b22),
      onSecondaryContainer: Color(0xffe6a786),
      tertiary: Color(0xffc7ce45),
      onTertiary: Color(0xff313300),
      tertiaryContainer: Color(0xffa4aa21),
      onTertiaryContainer: Color(0xff3a3c00),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff1b110d),
      onSurface: Color(0xfff2dfd6),
      onSurfaceVariant: Color(0xffddc1b4),
      outline: Color(0xffa48c80),
      outlineVariant: Color(0xff564339),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff2dfd6),
      inversePrimary: Color(0xff9e4300),
      primaryFixed: Color(0xffffdbcb),
      onPrimaryFixed: Color(0xff341100),
      primaryFixedDim: Color(0xffffb691),
      onPrimaryFixedVariant: Color(0xff783100),
      secondaryFixed: Color(0xffffdbcb),
      onSecondaryFixed: Color(0xff331100),
      secondaryFixedDim: Color(0xfffab896),
      onSecondaryFixedVariant: Color(0xff693b22),
      tertiaryFixed: Color(0xffe4ea5e),
      onTertiaryFixed: Color(0xff1c1d00),
      tertiaryFixedDim: Color(0xffc7ce45),
      onTertiaryFixedVariant: Color(0xff474a00),
      surfaceDim: Color(0xff1b110d),
      surfaceBright: Color(0xff433731),
      surfaceContainerLowest: Color(0xff150c08),
      surfaceContainerLow: Color(0xff231914),
      surfaceContainer: Color(0xff281d18),
      surfaceContainerHigh: Color(0xff332822),
      surfaceContainerHighest: Color(0xff3e322d),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffd3be),
      surfaceTint: Color(0xffffb691),
      onPrimary: Color(0xff441900),
      primaryContainer: Color(0xfff68544),
      onPrimaryContainer: Color(0xff2e0f00),
      secondary: Color(0xffffd3be),
      onSecondary: Color(0xff401b05),
      secondaryContainer: Color(0xffbe8365),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffdee459),
      onTertiary: Color(0xff262800),
      tertiaryContainer: Color(0xffa4aa21),
      onTertiaryContainer: Color(0xff181a00),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff1b110d),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfff4d6c9),
      outline: Color(0xffc7aca0),
      outlineVariant: Color(0xffa48b80),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff2dfd6),
      inversePrimary: Color(0xff7a3200),
      primaryFixed: Color(0xffffdbcb),
      onPrimaryFixed: Color(0xff230900),
      primaryFixedDim: Color(0xffffb691),
      onPrimaryFixedVariant: Color(0xff5e2500),
      secondaryFixed: Color(0xffffdbcb),
      onSecondaryFixed: Color(0xff230900),
      secondaryFixedDim: Color(0xfffab896),
      onSecondaryFixedVariant: Color(0xff552b13),
      tertiaryFixed: Color(0xffe4ea5e),
      onTertiaryFixed: Color(0xff111200),
      tertiaryFixedDim: Color(0xffc7ce45),
      onTertiaryFixedVariant: Color(0xff363900),
      surfaceDim: Color(0xff1b110d),
      surfaceBright: Color(0xff4f423c),
      surfaceContainerLowest: Color(0xff0d0603),
      surfaceContainerLow: Color(0xff251b16),
      surfaceContainer: Color(0xff302620),
      surfaceContainerHigh: Color(0xff3c302b),
      surfaceContainerHighest: Color(0xff473b35),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffece4),
      surfaceTint: Color(0xffffb691),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffffb088),
      onPrimaryContainer: Color(0xff1a0600),
      secondary: Color(0xffffece4),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xfff5b493),
      onSecondaryContainer: Color(0xff1a0600),
      tertiary: Color(0xfff1f86a),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffc4ca41),
      onTertiaryContainer: Color(0xff0b0c00),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff1b110d),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffffece4),
      outlineVariant: Color(0xffd9bdb0),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfff2dfd6),
      inversePrimary: Color(0xff7a3200),
      primaryFixed: Color(0xffffdbcb),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffffb691),
      onPrimaryFixedVariant: Color(0xff230900),
      secondaryFixed: Color(0xffffdbcb),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xfffab896),
      onSecondaryFixedVariant: Color(0xff230900),
      tertiaryFixed: Color(0xffe4ea5e),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffc7ce45),
      onTertiaryFixedVariant: Color(0xff111200),
      surfaceDim: Color(0xff1b110d),
      surfaceBright: Color(0xff5b4d47),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff281d18),
      surfaceContainer: Color(0xff392e28),
      surfaceContainerHigh: Color(0xff453933),
      surfaceContainerHighest: Color(0xff51443e),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
