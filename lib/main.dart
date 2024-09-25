import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'ui/seat_selection_screen.dart';
import 'ui/select_screen.dart';
import 'ui/home_screen.dart';
import 'ui/search_screen.dart';
import 'ui/all_trains_screen.dart';
import 'ui/all_hotels_screen.dart';
import 'utils/selection_button_provider.dart';
import 'utils/theme_data.dart';
import 'utils/theme_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://ibpilztrlcdwmuultgnu.supabase.co/',
    anonKey: 'your_anon_key', // Replace with your actual anon key
  );

  runApp(ScreenUtilInit(
    designSize: const Size(411, 821),
    builder: (context, widget) => MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SelectionButtonProvider()),
        ChangeNotifierProvider<ThemeHelper>(
          create: (context) =>
              ThemeHelper('light'), // Initialize with default theme
        ),
      ],
      child: Consumer<ThemeHelper>(
        builder: (context, themeHelper, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: themeHelper.themeMode == 'light'
                ? ThemeMode.light
                : ThemeMode.dark,
            theme: themeHelper.lightTheme,
            darkTheme: themeHelper.darkTheme,
            home: const HomeScreen(),
            routes: {
              '/select': (context) => const SelectScreen(),
              '/seat-selection': (context) =>
                  SeatSelectionScreen(trainId: 1), // Pass the actual train ID
              '/search': (context) => const SearchScreen(),
              '/all-trains': (context) => const AllTrainsScreen(),
              '/all-hotels': (context) => const AllHotelsScreen(),
            },
          );
        },
      ),
    );
  }
}
