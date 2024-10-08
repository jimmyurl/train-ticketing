import 'package:flutter/material.dart';
import 'package:Tikiti/ui/onboarding_screen.dart';


class LanguageSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Language'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OnboardingScreen(selectedLanguage: 'en'),
                  ),
                );
              },
              child: Text('English'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OnboardingScreen(selectedLanguage: 'sw'),
                  ),
                );
              },
              child: Text('Swahili'),
            ),
          ],
        ),
      ),
    );
  }
}
