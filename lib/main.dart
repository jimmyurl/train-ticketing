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
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlicGlsenRybGNkd211dWx0Z251Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjcyNTE4ODMsImV4cCI6MjA0MjgyNzg4M30.TmJbF1-nAWhxMYVVOkrLp3_sO0Nz4Q3y5X8vpG74TNc', // Replace with your actual anon key
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
            home: HomeScreen(),
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
