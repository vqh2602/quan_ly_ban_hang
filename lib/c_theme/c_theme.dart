import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Color a900 = const Color(0xff460210);
Color a800 = const Color(0xff860320);
Color a700 = const Color(0xffCC0530);
Color a600 = const Color(0xffF91F4E);
Color a500 = const Color(0xffFB6183);
Color a400 = const Color(0xffFC839D);
Color a300 = const Color(0xffFDA0B4);
Color a200 = const Color(0xffFDBECC);
Color a100 = const Color(0xffFEE1E7);
Color a50 = const Color(0xffFFF0F3);

Color b500 = const Color(0xff72B6F7);
Color bg500 = const Color(0xffFAFCFF);

class ThemeService {
  final _box = GetStorage();
  final _key = 'isThemeMode';

  ThemeMode get theme => loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  bool loadThemeFromBox() => _box.read(_key) ?? false;
  saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);

  void switchTheme() {
    Get.changeThemeMode(loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    saveThemeToBox(!loadThemeFromBox());
  }
}

class SThemeTask {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,

    /// Primary Color
    primaryColor: const Color(0xffFB6183),
    scaffoldBackgroundColor: const Color(0xffffffff),
    canvasColor: Colors.transparent,

    /// AppBar Theme
    appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xffffffff),
        iconTheme: IconThemeData(color: Color(0xff495057)),
        actionsIconTheme: IconThemeData(color: Color(0xff495057))),

    /// Card Theme
    cardTheme: const CardTheme(color: Color(0xfff0f0f0)),
    cardColor: const Color(0xfff0f0f0),

    /// Floating Action Theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: const Color(0xffFB6183),
        splashColor: const Color(0xffeeeeee).withAlpha(100),
        highlightElevation: 8,
        elevation: 4,
        focusColor: const Color(0xffFB6183),
        hoverColor: const Color(0xffFB6183),
        foregroundColor: const Color(0xffeeeeee)),

    /// Divider Theme
    dividerTheme:
        const DividerThemeData(color: Color(0xffe8e8e8), thickness: 1),
    dividerColor: const Color(0xffe8e8e8),

    /// Bottom AppBar Theme
    bottomAppBarTheme:
        const BottomAppBarTheme(color: Color(0xffFB6183), elevation: 2),

    /// Tab bar Theme
    tabBarTheme: const TabBarTheme(
      unselectedLabelColor: Color(0xff495057),
      labelColor: Color(0xffFB6183),
      indicatorSize: TabBarIndicatorSize.label,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: Color(0xffFB6183), width: 2.0),
      ),
    ),

    /// CheckBox theme
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all(const Color(0xffeeeeee)),
      fillColor: MaterialStateProperty.all(const Color(0xffFB6183)),
    ),

    /// Radio theme
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(const Color(0xffFB6183)),
    ),

    ///Switch Theme
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.resolveWith((state) {
        const Set<MaterialState> interactiveStates = <MaterialState>{
          MaterialState.pressed,
          MaterialState.hovered,
          MaterialState.focused,
          MaterialState.selected,
        };
        if (state.any(interactiveStates.contains)) {
          return const Color(0xffabb3ea);
        }
        return null;
      }),
      thumbColor: MaterialStateProperty.resolveWith((state) {
        const Set<MaterialState> interactiveStates = <MaterialState>{
          MaterialState.pressed,
          MaterialState.hovered,
          MaterialState.focused,
          MaterialState.selected,
        };
        if (state.any(interactiveStates.contains)) {
          return const Color(0xffFB6183);
        }
        return null;
      }),
    ),

    /// Slider Theme
    sliderTheme: SliderThemeData(
      activeTrackColor: const Color(0xffFB6183),
      inactiveTrackColor: const Color(0xffFB6183).withAlpha(140),
      trackShape: const RoundedRectSliderTrackShape(),
      trackHeight: 4.0,
      thumbColor: const Color(0xffFB6183),
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
      overlayShape: const RoundSliderOverlayShape(overlayRadius: 24.0),
      tickMarkShape: const RoundSliderTickMarkShape(),
      inactiveTickMarkColor: const Color(0xffFB6183).withOpacity(0.5),
      valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
      valueIndicatorTextStyle: const TextStyle(
        color: Color(0xffeeeeee),
      ),
    ),

    /// Other Colors
    splashColor: Colors.white.withAlpha(100),
    indicatorColor: const Color(0xffFB6183).withOpacity(0.5),
    highlightColor: const Color(0xffFB6183),
    colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xffFB6183),
            primary: const Color(0xffFB6183),
            onBackground: const Color(0xff000000),
            background: const Color(0xffffffff),
            brightness: Brightness.light)
        .copyWith(background: const Color(0xffffffff))
        .copyWith(error: const Color(0xfff0323c)),
  );

  /// -------------------------- Dark Theme  -------------------------------------------- ///
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,

    /// Primary Color
    primaryColor: const Color(0xffFB6183),

    /// Scaffold and Background color
    scaffoldBackgroundColor: const Color(0xff161616),
    canvasColor: Colors.transparent,

    /// AppBar Theme
    appBarTheme: const AppBarTheme(backgroundColor: Color(0xff161616)),

    /// Card Theme
    cardTheme: const CardTheme(color: Color(0xff222327)),
    cardColor: const Color(0xff222327),

    /// Input (Text-Field) Theme
    inputDecorationTheme: const InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(width: 1, color: Color(0xffFB6183)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(width: 1, color: Colors.white70),
      ),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1, color: Colors.white70)),
    ),

    /// Divider Color
    dividerTheme:
        const DividerThemeData(color: Color(0xff363636), thickness: 1),
    dividerColor: const Color(0xff363636),

    /// Floating Action Theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: const Color(0xffFB6183),
        splashColor: Colors.white.withAlpha(100),
        highlightElevation: 8,
        elevation: 4,
        focusColor: const Color(0xffFB6183),
        hoverColor: const Color(0xffFB6183),
        foregroundColor: Colors.white),

    /// Bottom AppBar Theme
    bottomAppBarTheme: const BottomAppBarTheme(
      color: Color(0xffFB6183),
      elevation: 2,
    ),

    /// Tab bar Theme
    tabBarTheme: const TabBarTheme(
      unselectedLabelColor: Color(0xff495057),
      labelColor: Color(0xffFB6183),
      indicatorSize: TabBarIndicatorSize.label,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: Color(0xffFB6183), width: 2.0),
      ),
    ),

    ///Switch Theme
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.resolveWith((state) {
        const Set<MaterialState> interactiveStates = <MaterialState>{
          MaterialState.pressed,
          MaterialState.hovered,
          MaterialState.focused,
          MaterialState.selected,
        };
        if (state.any(interactiveStates.contains)) {
          return const Color(0xffffffff);
        }
        return null;
      }),
      thumbColor: MaterialStateProperty.resolveWith((state) {
        const Set<MaterialState> interactiveStates = <MaterialState>{
          MaterialState.pressed,
          MaterialState.hovered,
          MaterialState.focused,
          MaterialState.selected,
        };
        if (state.any(interactiveStates.contains)) {
          return const Color(0xffFB6183);
        }
        return null;
      }),
    ),

    /// Slider Theme
    sliderTheme: SliderThemeData(
      activeTrackColor: const Color(0xffFB6183),
      inactiveTrackColor: const Color(0xffFB6183).withAlpha(100),
      trackShape: const RoundedRectSliderTrackShape(),
      trackHeight: 4.0,
      thumbColor: const Color(0xffFB6183),
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
      overlayShape: const RoundSliderOverlayShape(overlayRadius: 24.0),
      tickMarkShape: const RoundSliderTickMarkShape(),
      inactiveTickMarkColor: Colors.cyan[100],
      valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
      valueIndicatorTextStyle: const TextStyle(
        color: Colors.white,
      ),
    ),

    ///Other Color
    indicatorColor: Colors.white,
    disabledColor: const Color(0xffa3a3a3),

    highlightColor: Colors.white.withAlpha(28),
    splashColor: Colors.white.withAlpha(56),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xffFB6183),
      brightness: Brightness.dark,
      onBackground: const Color(0xffffffff),
      background: const Color(0xff000000),
    )
        .copyWith(background: const Color(0xff161616))
        .copyWith(error: const Color(0xfff0323c)),
  );
}
