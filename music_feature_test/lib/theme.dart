import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// white Mode
ThemeData whiteMode() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: const Color(0xFFE50914), // Red (Netflix-style accent)
      secondary: Colors.black, // Black for contrast
      surface: Colors.white, // White background
      error: Colors.redAccent, // Error color
    ),
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      displayLarge: GoogleFonts.montserrat(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      titleLarge: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      bodyLarge: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Colors.black87,
      ),
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFE50914), // Red accent
        foregroundColor: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    ),
    iconTheme: const IconThemeData(color: Color(0xFF333333), size: 24),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
      titleTextStyle: GoogleFonts.montserrat(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Color(0xFFE50914), // Red accent
      unselectedItemColor: Colors.grey,
      elevation: 8,
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: const Color(0xFFE50914),
      inactiveTrackColor: Colors.grey.shade400,
      thumbColor: const Color(0xFFE50914),
      overlayColor: const Color(0x29E50914),
      trackHeight: 4.0,
    ),
  );
}

ThemeData darkMode() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: const Color(0xFFE50914), // Red (Netflix-style accent)
      secondary: Colors.white, // White for contrast
      surface: const Color(0xFF121212), // Dark background
      error: Colors.redAccent, // Error color
    ),
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      displayLarge: GoogleFonts.montserrat(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      titleLarge: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      bodyLarge: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Colors.white70,
      ),
    ),
    cardTheme: CardTheme(
      color: const Color(0xFF1E1E1E),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFE50914), // Red accent
        foregroundColor: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.white, size: 24),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF121212),
      foregroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: GoogleFonts.montserrat(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF1E1E1E),
      selectedItemColor: Color(0xFFE50914), // Red accent
      unselectedItemColor: Colors.grey,
      elevation: 8,
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: const Color(0xFFE50914),
      inactiveTrackColor: Colors.grey.shade700,
      thumbColor: const Color(0xFFE50914),
      overlayColor: const Color(0x29E50914),
      trackHeight: 4.0,
    ),
  );
}
