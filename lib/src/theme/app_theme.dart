import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme{

  static final ThemeData lightTheme = ThemeData(
/*      colorScheme: const ColorScheme.light(
        primary: AppColor.lightPrimaryColor,
        secondary: AppColor.lightSecondaryColor,
        onPrimary: AppColor.lightOnPrimaryColor,
      ),*/
      iconTheme: IconThemeData(
        color: AppColor.iconColor,
      ),
      textTheme: TextTheme(
        headlineMedium: GoogleFonts.montserrat(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        headlineSmall: GoogleFonts.montserrat(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.w400,
        ),
        titleLarge:GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
        ),
        titleMedium: GoogleFonts.montserrat(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        titleSmall: GoogleFonts.montserrat(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        displayLarge:GoogleFonts.montserrat(
            color: Colors.black,
            fontSize: 112,
            fontWeight: FontWeight.w100,
        ),
        displayMedium: GoogleFonts.montserrat(
          color: Colors.black,
          fontSize: 56,
          fontWeight: FontWeight.w400,
        ),
        displaySmall: GoogleFonts.montserrat(
          color: Colors.black,
          fontSize: 45,
          fontWeight: FontWeight.w400,
        ),
        bodyLarge: GoogleFonts.montserrat(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        bodyMedium: GoogleFonts.montserrat(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        bodySmall: GoogleFonts.montserrat(
          color: Colors.black,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
         labelLarge: GoogleFonts.montserrat(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
         labelSmall: GoogleFonts.montserrat(
          color: Colors.black,
          fontSize: 10,
          fontWeight: FontWeight.w400,
        ),

      ),
      dividerTheme: const DividerThemeData(
          color: Colors.black12
      )

  );
}