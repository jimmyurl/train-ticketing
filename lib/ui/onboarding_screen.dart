import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Tikiti/generated/l10n.dart';  // Ensure you have your localization file imported
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  final String selectedLanguage;

  OnboardingScreen({required this.selectedLanguage});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  List<Map<String, String>> onboardingData = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Load localization here instead of initState
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    try {
      await S.load(Locale(widget.selectedLanguage));
      // Use setState to rebuild the UI with the new language
      setState(() {
        onboardingData = [
          {
            'image': 'assets/images/onboarding1.jpg',
            'title': S.of(context).onboardingTitle1,
            'subtitle': S.of(context).onboardingSubtitle1,
          },
          {
            'image': 'assets/images/onboarding2.png',
            'title': S.of(context).onboardingTitle2,
            'subtitle': S.of(context).onboardingSubtitle2,
          },
          {
            'image': 'assets/images/onboarding3.jpeg',
            'title': S.of(context).onboardingTitle3,
            'subtitle': S.of(context).onboardingSubtitle3,
          },
        ];
      });
    } catch (e) {
      // Handle any loading errors here
      print("Error loading language: $e");
    }
  }

  void _onNextPage() {
    if (_currentPage < onboardingData.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingCompleted', true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (onboardingData.isEmpty) {
      // While loading, show a progress indicator
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (int index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: onboardingData.length,
                itemBuilder: (context, index) => OnboardingContent(
                  image: onboardingData[index]['image']!,
                  title: onboardingData[index]['title']!,
                  subtitle: onboardingData[index]['subtitle']!,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _currentPage < onboardingData.length - 1
                      ? TextButton(
                          onPressed: _completeOnboarding,
                          child: Text(
                            S.of(context).skip,
                            style: TextStyle(fontSize: 18.sp, color: Colors.grey),
                          ),
                        )
                      : Container(),
                  ElevatedButton(
                    onPressed: _onNextPage,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                    ),
                    child: Text(
                      _currentPage == onboardingData.length - 1
                          ? S.of(context).getStarted
                          : S.of(context).next,
                      style: TextStyle(fontSize: 18.sp),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


class OnboardingContent extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;

  const OnboardingContent({
    required this.image,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: Image.asset(
              image,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Poppins',
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.grey,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}
