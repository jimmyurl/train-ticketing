import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:Tikiti/generated/l10n.dart';
import 'ui/seat_selection_screen.dart';
import 'ui/select_screen.dart';
import 'ui/home_screen.dart';
import 'ui/search_screen.dart';
import 'ui/all_trains_screen.dart';
import 'ui/all_hotels_screen.dart';
import 'ui/onboarding_screen.dart';
import 'ui/language_selection_screen.dart';
import 'utils/selection_button_provider.dart';
import 'utils/theme_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
            home: MyAppStarter(),
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

class MyAppStarter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkIfLanguageSelected(),
      builder: (context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.data == true) {
          return FutureBuilder(
            future: checkIfOnboardingCompleted(),
            builder: (context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (snapshot.data == true) {
                return const MyHomePage();
              } else {
                return OnboardingScreen(selectedLanguage: getCurrentLanguage());
              }
            },
          );
        } else {
          return LanguageSelectionScreen();
        }
      },
    );
  }

  Future<bool> checkIfLanguageSelected() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('languageSelected') ?? false;
  }

  Future<bool> checkIfOnboardingCompleted() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('onboardingCompleted') ?? false;
  }

  String getCurrentLanguage() {
    // TODO: Implement logic to get the current language
    // For now, we'll return a default value
    return 'en';
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
    AllTrainsScreen(),
    AllHotelsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = S.of(context);

    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: const ImageIcon(AssetImage("assets/icons/home.png")),
            label: localizations.home,
          ),
          BottomNavigationBarItem(
            icon: const ImageIcon(AssetImage("assets/icons/search.png")),
            label: localizations.search,
          ),
          BottomNavigationBarItem(
            icon: const ImageIcon(AssetImage("assets/icons/train.png")),
            label: localizations.trains,
          ),
          BottomNavigationBarItem(
            icon: const ImageIcon(AssetImage("assets/icons/hotel.png")),
            label: localizations.hotels,
          ),
          BottomNavigationBarItem(
            icon: const ImageIcon(AssetImage("assets/icons/profile.png")),
            label: localizations.profile,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
      ),
    );
  }
}