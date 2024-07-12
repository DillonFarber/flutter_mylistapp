import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class MyColors extends MaterialColor {
  const MyColors(super.primary, super.swatch);

  static const Color transparent = Colors.transparent;

  static const Color black54 = Colors.black54;
  static const Color black = Colors.black;

  static const Color primary = Colors.black;
  static const Color secondary = Color.fromARGB(255, 204, 204, 204);
  static const Color inversePrimary = Color.fromARGB(10, 0, 0, 0);

  static const Color bgColor = Color.fromARGB(255, 60, 60, 60);
  static const Color onBGColor = Color.fromARGB(255, 100, 95, 95);
  static const Color body_color = Color.fromARGB(255, 0, 103, 103);

  static const Color white = Colors.white;

  static const Color teal = Color.fromARGB(255, 0, 165, 165);
  static const Color veryDarkCyan = Color.fromARGB(255, 0, 103, 103);

  static const Color softBlue = Color.fromARGB(255, 67, 70, 164);
  static const Color softBabyBlue = Color.fromARGB(255, 73, 144, 177);
  static const Color softPurple = Color.fromARGB(255, 138, 59, 227);

  static const Color darkRed = Color.fromARGB(255, 108, 23, 23);
  static const Color darkTeal = Color.fromARGB(255, 16, 101, 91);
}

final ThemeData myTheme = ThemeData(
  primaryColor: MyColors.veryDarkCyan,
  hintColor: MyColors.black,
);

class MyAppTheme {
  static ThemeData getMyAppTheme() {
    return ThemeData(
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          titleTextStyle: GoogleFonts.getFont('Outfit',
              fontSize: 18, fontWeight: FontWeight.bold, color: MyColors.white),
          actionsIconTheme: const IconThemeData(color: MyColors.primary),
          iconTheme: const IconThemeData(color: MyColors.primary),
          backgroundColor: MyColors.white,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        cardTheme: const CardTheme(color: MyColors.black),
        primaryColor: MyColors.primary,
        highlightColor: MyColors.primary,
        scaffoldBackgroundColor: MyColors.teal,
        textTheme: TextTheme(
          displayLarge: GoogleFonts.getFont('Outfit',
              fontSize: 20, fontWeight: FontWeight.bold, color: MyColors.white),
          displayMedium: GoogleFonts.getFont('Outfit',
              fontSize: 18, fontWeight: FontWeight.bold, color: MyColors.white),
          displaySmall: GoogleFonts.getFont('Outfit',
              fontSize: 16, fontWeight: FontWeight.bold, color: MyColors.white),
          titleLarge: GoogleFonts.getFont('Outfit',
              fontSize: 18, fontWeight: FontWeight.bold, color: MyColors.white),
          titleMedium: GoogleFonts.getFont('Outfit',
              fontSize: 14, fontWeight: FontWeight.bold, color: MyColors.white),
          titleSmall: GoogleFonts.getFont('Outfit',
              fontSize: 12, fontWeight: FontWeight.bold, color: MyColors.white),
          bodyLarge: GoogleFonts.getFont('Outfit',
              fontSize: 16, color: MyColors.white, backgroundColor: MyColors.black),
          bodyMedium: GoogleFonts.getFont('Outfit',
              fontSize: 14, color: MyColors.white),
          bodySmall: GoogleFonts.getFont('Outfit',
              fontSize: 12, color: MyColors.white.withOpacity(0.4)),
          labelLarge: GoogleFonts.getFont('Outfit',
              fontSize: 14, color: MyColors.white),
          labelMedium: GoogleFonts.getFont('Outfit',
              fontSize: 14, color: MyColors.black, fontWeight: FontWeight.bold),
          labelSmall: GoogleFonts.getFont('Outfit',
              fontSize: 10, color: MyColors.black.withOpacity(0.4)),
        ),
        iconTheme: const IconThemeData(color: MyColors.white),
        primaryIconTheme:
            const IconThemeData(color: MyColors.darkTeal, size: 50.0),
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(MyColors.body_color),
                foregroundColor:
                    MaterialStateProperty.all<Color>(MyColors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)))))),
        toggleButtonsTheme: ToggleButtonsThemeData(
          selectedColor: MyColors.body_color,
          fillColor: MyColors.body_color.withOpacity(0.1),
          textStyle: const TextStyle(color: MyColors.white),
          selectedBorderColor: MyColors.body_color,
          borderRadius: BorderRadius.circular(8.0),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: MyColors.black54,
          onPrimary: MyColors.primary,
          primaryContainer: MyColors.darkRed,
          onPrimaryContainer: MyColors.darkTeal,
          inversePrimary: MyColors.inversePrimary,
          secondary: MyColors.secondary,
          onSecondary: MyColors.secondary,
          secondaryContainer: MyColors.bgColor,
          onSecondaryContainer: MyColors.bgColor,
          tertiary: MyColors.darkTeal,
          onTertiary: MyColors.darkRed,
          tertiaryContainer: MyColors.bgColor,
          onTertiaryContainer: MyColors.bgColor,
          surface: MyColors.bgColor,
          onSurface: MyColors.bgColor,
          error: Colors.red,
          onError: Colors.red,
          errorContainer: MyColors.bgColor,
          onErrorContainer: MyColors.bgColor,
          background: MyColors.bgColor,
          onBackground: MyColors.onBGColor,
          outline: MyColors.bgColor,
          outlineVariant: MyColors.bgColor,
          shadow: MyColors.bgColor,
          scrim: MyColors.bgColor,
          inverseSurface: MyColors.bgColor,
          onInverseSurface: MyColors.bgColor,
          surfaceTint: MyColors.teal,
          brightness: Brightness.dark,
        ),
        popupMenuTheme: PopupMenuThemeData(
            color: MyColors.black,
            // shape: ShapeBorder,
            elevation: 0.0,
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            textStyle: GoogleFonts.getFont('Outfit',
                fontSize: 10, color: MyColors.black.withOpacity(0.4)),
            enableFeedback: false,
            position: PopupMenuPosition.under,
            iconColor: Colors.transparent,
            iconSize: 12.0),
        listTileTheme: const ListTileThemeData());
  }
}
