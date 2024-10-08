import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Tikiti/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  final String selectedLanguage;

  OnboardingScreen({required this.selectedLanguage});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late Future<List<dynamic>> onboardingData; // Changed to Future

  @override
  void initState() {
    super.initState();
    onboardingData = loadOnboardingData(); // Initialize the data asynchronously
  }

  Future<List<dynamic>> loadOnboardingData() async {
    // Simulate loading data (e.g., from a file, database, or API)
    await Future.delayed(Duration(seconds: 2)); // Example delay
    return [
      {'title': 'Welcome', 'description': 'Discover the app!'},
      {'title': 'Explore', 'description': 'Find various services easily!'},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: onboardingData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Show a loader while waiting
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error loading data'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          }

          // Use the data (snapshot.data) to build your onboarding screens
          return PageView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final onboardingItem = snapshot.data![index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(onboardingItem['title'],
                      style: Theme.of(context).textTheme.headline4),
                  SizedBox(height: 20),
                  Text(onboardingItem['description'],
                      style: Theme.of(context).textTheme.subtitle1),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
