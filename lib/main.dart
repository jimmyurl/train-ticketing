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
import 'ui/onboarding_screen.dart'; // Import Onboarding Screen
import 'utils/selection_button_provider.dart';
import 'utils/theme_data.dart';
import 'utils/theme_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  await Supabase.initialize(
    url:
        'https://ibpilztrlcdwmuultgnu.supabase.co/', // Replace with your actual Supabase URL
    anonKey:
        'YOUR_SUPABASE_ANON_KEY', // Replace with your actual Supabase anon key
  );

  runApp(ScreenUtilInit(
    designSize: const Size(411, 821), // Set your design size
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
            home: const MyHomePage(),
          );
        },
      ),
    );
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
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/icons/home.png")),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/icons/search.png")),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/icons/hotel.png")),
            label: 'Hotels',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/icons/profile.png")),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue, // Change this color to match your theme
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
