import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:Tikiti/generated/l10n.dart';
import 'package:Tikiti/ui/home_screen.dart'; // Ensure this is your actual home screen file
import 'package:Tikiti/ui/search_screen.dart'; // Ensure this is your actual search screen file
import 'package:Tikiti/ui/profile_screen.dart'; // Ensure this is your actual profile screen file
import 'utils/selection_button_provider.dart';
import 'utils/theme_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ibpilztrlcdwmuultgnu.supabase.co/',
    anonKey: 'YOUR_SUPABASE_ANON_KEY', // Replace with your actual anon key
  );

  runApp(ScreenUtilInit(
    designSize: const Size(411, 821),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context, child) => MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SelectionButtonProvider()),
        ChangeNotifierProvider<ThemeHelper>(
          create: (context) => ThemeHelper('light'),
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
            home: MyHomePage(),
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          const HomeScreen(), // Ensure this class is correctly defined and imported
          SearchScreen(), // Ensure this class is correctly defined and imported
          ProfileScreen(), // Ensure this class is correctly defined and imported
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icons/home.png')),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icons/search.png')),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icons/profile.png')),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}