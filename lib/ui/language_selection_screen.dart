import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Tikiti/generated/l10n.dart';
import 'onboarding_screen.dart';

class LanguageSelectionScreen extends StatefulWidget {
  @override
  _LanguageSelectionScreenState createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String selectedLanguage = 'en'; // Default language

  void _onProceed() async {
    // Save the selected language
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLanguage', selectedLanguage);
    await prefs.setBool('languageSelected', true);

    // Update the app's locale
    await S.load(Locale(selectedLanguage));

    // Navigate to OnboardingScreen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => OnboardingScreen(
          selectedLanguage: selectedLanguage,
        ),
      ),
    );
  }

  void _setLanguage(String langCode) {
    setState(() {
      selectedLanguage = langCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                'Select Language',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 40.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => _setLanguage('en'),
                  child: Text(
                    'English',
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: selectedLanguage == 'en' ? Colors.blue : Colors.black,
                    ),
                  ),
                ),
                SizedBox(width: 30.w),
                TextButton(
                  onPressed: () => _setLanguage('sw'),
                  child: Text(
                    'Swahili',
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: selectedLanguage == 'sw' ? Colors.blue : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.h),
            ElevatedButton(
              onPressed: _onProceed,
              child: Text('Proceed', style: TextStyle(fontSize: 18.sp)),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 15.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}