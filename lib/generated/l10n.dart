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
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
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
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Kids & Clouds`
  String get appTitle {
    return Intl.message('Kids & Clouds', name: 'appTitle', desc: '', args: []);
  }

  /// `Application for managing children`
  String get appSubtitle {
    return Intl.message(
      'Application for managing children',
      name: 'appSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Continue`
  String get continueText {
    return Intl.message('Continue', name: 'continueText', desc: '', args: []);
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Daily Journal`
  String get diary {
    return Intl.message('Daily Journal', name: 'diary', desc: '', args: []);
  }

  /// `List`
  String get list {
    return Intl.message('List', name: 'list', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Welcome`
  String get welcome {
    return Intl.message('Welcome', name: 'welcome', desc: '', args: []);
  }

  /// `Children List`
  String get childrenList {
    return Intl.message(
      'Children List',
      name: 'childrenList',
      desc: '',
      args: [],
    );
  }

  /// `Child Details`
  String get childDetails {
    return Intl.message(
      'Child Details',
      name: 'childDetails',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loading {
    return Intl.message('Loading...', name: 'loading', desc: '', args: []);
  }

  /// `An error occurred`
  String get error {
    return Intl.message('An error occurred', name: 'error', desc: '', args: []);
  }

  /// `No data available`
  String get noData {
    return Intl.message(
      'No data available',
      name: 'noData',
      desc: '',
      args: [],
    );
  }

  /// `Refresh`
  String get refresh {
    return Intl.message('Refresh', name: 'refresh', desc: '', args: []);
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Phone`
  String get phone {
    return Intl.message('Phone', name: 'phone', desc: '', args: []);
  }

  /// `City`
  String get city {
    return Intl.message('City', name: 'city', desc: '', args: []);
  }

  /// `Country`
  String get country {
    return Intl.message('Country', name: 'country', desc: '', args: []);
  }

  /// `Welcome to Kids & Clouds`
  String get splash1Title {
    return Intl.message(
      'Welcome to Kids & Clouds',
      name: 'splash1Title',
      desc: '',
      args: [],
    );
  }

  /// `Manage your children's data`
  String get splash2Title {
    return Intl.message(
      'Manage your children\'s data',
      name: 'splash2Title',
      desc: '',
      args: [],
    );
  }

  /// `Enjoy a safe and fun environment for your kids`
  String get splash3Title {
    return Intl.message(
      'Enjoy a safe and fun environment for your kids',
      name: 'splash3Title',
      desc: '',
      args: [],
    );
  }

  /// `Your children's data is completely safe and protected with us. We prioritize privacy and security to give you peace of mind.`
  String get splash1Subtitle {
    return Intl.message(
      'Your children\'s data is completely safe and protected with us. We prioritize privacy and security to give you peace of mind.',
      name: 'splash1Subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Easily manage and track your children's daily activities with our intuitive tools. Stay updated and engaged with their progress every step of the way.`
  String get splash2Subtitle {
    return Intl.message(
      'Easily manage and track your children\'s daily activities with our intuitive tools. Stay updated and engaged with their progress every step of the way.',
      name: 'splash2Subtitle',
      desc: '',
      args: [],
    );
  }

  /// `A secure and fun space where your children can learn, play, and grow. We provide a safe environment that fosters creativity and development.`
  String get splash3Subtitle {
    return Intl.message(
      'A secure and fun space where your children can learn, play, and grow. We provide a safe environment that fosters creativity and development.',
      name: 'splash3Subtitle',
      desc: '',
      args: [],
    );
  }

  /// `You have`
  String get youHave {
    return Intl.message('You have', name: 'youHave', desc: '', args: []);
  }

  /// `children`
  String get children {
    return Intl.message('children', name: 'children', desc: '', args: []);
  }

  /// `Select Language`
  String get selectLanguage {
    return Intl.message(
      'Select Language',
      name: 'selectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `username`
  String get username {
    return Intl.message('username', name: 'username', desc: '', args: []);
  }

  /// `password`
  String get password {
    return Intl.message('password', name: 'password', desc: '', args: []);
  }

  /// `Login`
  String get loginButton {
    return Intl.message('Login', name: 'loginButton', desc: '', args: []);
  }

  /// `Logout`
  String get logoutButton {
    return Intl.message('Logout', name: 'logoutButton', desc: '', args: []);
  }

  /// `Personal Information`
  String get personalInfo {
    return Intl.message(
      'Personal Information',
      name: 'personalInfo',
      desc: '',
      args: [],
    );
  }

  /// `Legal Guardian's Phone`
  String get telephone {
    return Intl.message(
      'Legal Guardian\'s Phone',
      name: 'telephone',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message('Gender', name: 'gender', desc: '', args: []);
  }

  /// `Settings`
  String get configuration {
    return Intl.message('Settings', name: 'configuration', desc: '', args: []);
  }

  /// `Activity`
  String get activity {
    return Intl.message('Activity', name: 'activity', desc: '', args: []);
  }

  /// `General`
  String get general {
    return Intl.message('General', name: 'general', desc: '', args: []);
  }

  /// `Find children by name`
  String get findChildrenByName {
    return Intl.message(
      'Find children by name',
      name: 'findChildrenByName',
      desc: '',
      args: [],
    );
  }

  /// `No results found`
  String get noResultsFound {
    return Intl.message(
      'No results found',
      name: 'noResultsFound',
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
      Locale.fromSubtags(languageCode: 'es'),
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
