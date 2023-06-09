import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const LinearGradient gradient = LinearGradient(colors: []);

  static const Color pinkSalmon = Color(0xFFFE95B4);
  static const Color frenchRose = Color(0xFFF15082);
  static const LinearGradient pinkGradient = LinearGradient(
    colors: [pinkSalmon, frenchRose],
  );

  static const Color lightBrown = Color(0xFFFEB395);
  static const Color brown = Color(0xFFF17E50);
  static const LinearGradient brownGradient = LinearGradient(
    colors: [lightBrown, brown],
  );

  static const Color lightLemon = Color(0xFFFEED95);
  static const Color lemon = Color(0xFFF1D650);
  static const LinearGradient lemonGradient = LinearGradient(
    colors: [lightLemon, lemon],
  );

  static const Color lightTosca = Color(0xFF95D1FE);
  static const Color tosca = Color(0xFF509EF1);
  static const LinearGradient toscaGradient = LinearGradient(
    colors: [lightTosca, tosca],
  );

  static const Color lightDonker = Color(0xFF9C95FE);
  static const Color donker = Color(0xFF6850F1);
  static const LinearGradient donkerGradient = LinearGradient(
    colors: [lightDonker, donker],
  );

  static const Color perano = Color(0xFFB09DF2);
  static const Color cornflowerBlue = Color(0xFF8C77FB);
  static const LinearGradient purpleGradient = LinearGradient(
    colors: [perano, cornflowerBlue],
  );

  static const Color flesh = Color(0xFFFED3A0);
  static const Color yellowOrange = Color(0xFFFFA63F);
  static const LinearGradient orangeGradient = LinearGradient(
    colors: [flesh, yellowOrange],
  );

  static const Color anakiwa = Color(0xFF9FE7FB);
  static const Color pictonBlue = Color(0xFF46C6E9);
  static const LinearGradient blueGradient = LinearGradient(
    colors: [anakiwa, pictonBlue],
  );

  static const Color lightOrange = Color(0xFFFFCB52);
  static const Color orange = Color(0xFFFF7B02);
  static const LinearGradient darkOrangeGradient = LinearGradient(
    colors: [pinkSalmon, frenchRose],
  );

  static const Color lightGreen = Color(0xFF2AFEB7);
  static const Color green = Color(0xFF08C792);
  static const LinearGradient greenGradient = LinearGradient(
    colors: [lightGreen, green],
  );

  static const Color yellow = Color(0xFFFFE324);
  static const Color darkYellow = Color(0xFFFFB533);
  static const LinearGradient yellowGradient = LinearGradient(
    colors: [yellow, darkYellow],
  );

  static const Color greyBlue = Color(0xFF5581F1);
  static const Color darkBlue = Color(0xFF1153FC);
  static const LinearGradient darkBlueGradient = LinearGradient(
    colors: [greyBlue, darkBlue],
  );

  static const List<LinearGradient> listGradient = [
    pinkGradient,
    purpleGradient,
    orangeGradient,
    blueGradient,
    darkOrangeGradient,
    greenGradient,
    yellowGradient,
    darkBlueGradient,
    brownGradient,
    lemonGradient,
    toscaGradient,
    donkerGradient,
  ];

  static const Color lightPurple = Color(0xFFE594FF);

  static const Color boldColorFont = Color(0xFF2A2E49);
  static const Color normalColorFont = Color(0xFFa2a1ae);

  static const Color darkGrey = Color(0xFF6C6C6C);
  static const Color grey = Color(0xFFB7B7B7);

  static const Color scaffoldColor = Color(0xFFFBFAFF);

  static const Color greenPastel = Color(0xFF90F0B3);
  static const Color redPastel = Color(0xFFF97C7C);
  static const Color redDarkPastel = Color(0xFFC23A22);

  static const TextStyle headline1 = TextStyle(
    fontSize: 28,
    color: boldColorFont,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle headline2 = TextStyle(
    fontSize: 26,
    color: boldColorFont,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle headline3 = TextStyle(
    fontSize: 20,
    color: boldColorFont,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle text1 = TextStyle(
    fontSize: 16,
    color: normalColorFont,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle text3 = TextStyle(
    fontSize: 14,
    color: normalColorFont,
    fontWeight: FontWeight.w500,
  );

  static OutlineInputBorder enabledBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: AppTheme.perano),
  );

  static OutlineInputBorder focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: AppTheme.cornflowerBlue),
  );

  static OutlineInputBorder errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: AppTheme.redPastel),
  );

  static OutlineInputBorder focusedErrorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: AppTheme.redDarkPastel),
  );

  static List<BoxShadow> getShadow(Color color) {
    return [
      BoxShadow(
        color: color.withOpacity(0.3),
        offset: const Offset(0, 6),
        blurRadius: 10,
        spreadRadius: 2,
      ),
    ];
  }

  static const Color notWhite = Color(0xFFEDF0F2);
  static const Color nearlyWhite = Color(0xFFFEFEFE);
  static const Color white = Color(0xFFFFFFFF);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color darkgrey = Color(0xFF313A44);

  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color chipBackground = Color(0xFFEEF1F3);
  static const Color spacer = Color(0xFFF2F2F2);
  static const String fontName = 'WorkSans';

  static const TextTheme textTheme = TextTheme(
    headlineMedium: display1,
    headlineSmall: headline,
    titleLarge: title,
    titleSmall: subtitle,
    bodyMedium: body2,
    bodyLarge: body1,
    bodySmall: caption,
  );

  static const TextStyle display1 = TextStyle(
    // h4 -> display1
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkerText,
  );

  static const TextStyle headline = TextStyle(
    // h5 -> headline
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
    color: darkerText,
  );

  static const TextStyle title = TextStyle(
    // h6 -> title
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: darkerText,
  );

  static const TextStyle subtitle = TextStyle(
    // subtitle2 -> subtitle
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: darkText,
  );

  static const TextStyle body2 = TextStyle(
    // body1 -> body2
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: darkText,
  );

  static const TextStyle body1 = TextStyle(
    // body2 -> body1
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkText,
  );

  static const TextStyle caption = TextStyle(
    // Caption -> caption
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: lightText, // was lightText
  );
}
