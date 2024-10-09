import 'package:flutter/material.dart';

class LocaleProvider extends InheritedWidget {
  final Locale locale;
  final Function(Locale) changeLocale;

  const LocaleProvider({
    Key? key,
    required this.locale,
    required this.changeLocale,
    required Widget child,
  }) : super(key: key, child: child);

  static LocaleProvider of(BuildContext context) {
    final LocaleProvider? result = context.dependOnInheritedWidgetOfExactType<LocaleProvider>();
    assert(result != null, 'No LocaleProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(LocaleProvider oldWidget) {
    return locale != oldWidget.locale;
  }
}

class LocaleProviderWrapper extends StatefulWidget {
  final Widget child;

  const LocaleProviderWrapper({Key? key, required this.child}) : super(key: key);

  @override
  _LocaleProviderWrapperState createState() => _LocaleProviderWrapperState();
}

class _LocaleProviderWrapperState extends State<LocaleProviderWrapper> {
  Locale _locale = const Locale('en');

  void _changeLocale(Locale newLocale) {
    setState(() {
      _locale = newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LocaleProvider(
      locale: _locale,
      changeLocale: _changeLocale,
      child: widget.child,
    );
  }
}