// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome to Tikiti`
  String get onboardingTitle1 {
    return Intl.message(
      'Welcome to Tikiti',
      name: 'onboardingTitle1',
      desc: '',
      args: [],
    );
  }

  /// `Find and book your trips easily`
  String get onboardingSubtitle1 {
    return Intl.message(
      'Find and book your trips easily',
      name: 'onboardingSubtitle1',
      desc: '',
      args: [],
    );
  }

  /// `Book Your Tickets`
  String get onboardingTitle2 {
    return Intl.message(
      'Book Your Tickets',
      name: 'onboardingTitle2',
      desc: '',
      args: [],
    );
  }

  /// `Browse through available trains and hotels`
  String get onboardingSubtitle2 {
    return Intl.message(
      'Browse through available trains and hotels',
      name: 'onboardingSubtitle2',
      desc: '',
      args: [],
    );
  }

  /// `Enjoy Your Journey`
  String get onboardingTitle3 {
    return Intl.message(
      'Enjoy Your Journey',
      name: 'onboardingTitle3',
      desc: '',
      args: [],
    );
  }

  /// `Have a wonderful experience with your bookings`
  String get onboardingSubtitle3 {
    return Intl.message(
      'Have a wonderful experience with your bookings',
      name: 'onboardingSubtitle3',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message(
      'Get Started',
      name: 'getStarted',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Tikiti`
  String get appTitle {
    return Intl.message(
      'Tikiti',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `From (Departure)`
  String get fromHint {
    return Intl.message(
      'From (Departure)',
      name: 'fromHint',
      desc: '',
      args: [],
    );
  }

  /// `To (Destination)`
  String get toHint {
    return Intl.message(
      'To (Destination)',
      name: 'toHint',
      desc: '',
      args: [],
    );
  }

  /// `Round Trip`
  String get returnTrip {
    return Intl.message(
      'Round Trip',
      name: 'returnTrip',
      desc: '',
      args: [],
    );
  }

  /// `Departure`
  String get departure {
    return Intl.message(
      'Departure',
      name: 'departure',
      desc: '',
      args: [],
    );
  }

  /// `Return`
  String get returnDate {
    return Intl.message(
      'Return',
      name: 'returnDate',
      desc: '',
      args: [],
    );
  }

  /// `Select departure date`
  String get selectDepartureDate {
    return Intl.message(
      'Select departure date',
      name: 'selectDepartureDate',
      desc: '',
      args: [],
    );
  }

  /// `Select return date`
  String get selectReturnDate {
    return Intl.message(
      'Select return date',
      name: 'selectReturnDate',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Plan your journey effortlessly...`
  String get planYourJourney {
    return Intl.message(
      'Plan your journey effortlessly...',
      name: 'planYourJourney',
      desc: '',
      args: [],
    );
  }

  /// `Trains`
  String get trains {
    return Intl.message(
      'Trains',
      name: 'trains',
      desc: '',
      args: [],
    );
  }

  /// `Bus`
  String get bus {
    return Intl.message(
      'Bus',
      name: 'bus',
      desc: '',
      args: [],
    );
  }

  /// `Flight`
  String get flight {
    return Intl.message(
      'Flight',
      name: 'flight',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Hotels`
  String get hotels {
    return Intl.message(
      'Hotels',
      name: 'hotels',
      desc: '',
      args: [],
    );
  }

  /// `Saved`
  String get saved {
    return Intl.message(
      'Saved',
      name: 'saved',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'sw'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
