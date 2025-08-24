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

  /// `Discover the best beauty centers\nnear you`
  String get onboardingWelcomeText {
    return Intl.message(
      'Discover the best beauty centers\nnear you',
      name: 'onboardingWelcomeText',
      desc: 'Welcome text for the onboarding screen',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: 'Label for the register button',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: 'Label for the login button',
      args: [],
    );
  }

  /// `Create an account`
  String get createAccount {
    return Intl.message(
      'Create an account',
      name: 'createAccount',
      desc: 'Text for creating a new account',
      args: [],
    );
  }

  /// `Welcome back`
  String get welcomeBack {
    return Intl.message(
      'Welcome back',
      name: 'welcomeBack',
      desc: 'Welcome message for returning users',
      args: [],
    );
  }

  /// `Log in to your account`
  String get loginText {
    return Intl.message(
      'Log in to your account',
      name: 'loginText',
      desc: 'Text for the login screen',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: 'Label for the email field',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: 'Label for the password field',
      args: [],
    );
  }

  /// `Forgot your password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot your password?',
      name: 'forgotPassword',
      desc: 'Text for the forgot password link',
      args: [],
    );
  }

  /// `Remember me`
  String get rememberMe {
    return Intl.message(
      'Remember me',
      name: 'rememberMe',
      desc: 'Label for the remember me checkbox',
      args: [],
    );
  }

  /// `Don't have an account? `
  String get dontHaveAccount {
    return Intl.message(
      'Don\'t have an account? ',
      name: 'dontHaveAccount',
      desc: 'Prompt for users without an account',
      args: [],
    );
  }

  /// `Create your new account`
  String get createNewAccount {
    return Intl.message(
      'Create your new account',
      name: 'createNewAccount',
      desc: 'Text for creating a new account',
      args: [],
    );
  }

  /// `Full name`
  String get fullName {
    return Intl.message(
      'Full name',
      name: 'fullName',
      desc: 'Label for the full name field',
      args: [],
    );
  }

  /// `Or continue with`
  String get orContinueWith {
    return Intl.message(
      'Or continue with',
      name: 'orContinueWith',
      desc: 'Text for alternative login options',
      args: [],
    );
  }

  /// `Already have an account? `
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an account? ',
      name: 'alreadyHaveAccount',
      desc: 'Prompt for users who already have an account',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: 'Label for the search function',
      args: [],
    );
  }

  /// `Beauty Support`
  String get beautySupport {
    return Intl.message(
      'Beauty Support',
      name: 'beautySupport',
      desc: 'App title',
      args: [],
    );
  }

  /// `Centers`
  String get centers {
    return Intl.message(
      'Centers',
      name: 'centers',
      desc: 'Label for beauty centers',
      args: [],
    );
  }

  /// `Center`
  String get center {
    return Intl.message(
      'Center',
      name: 'center',
      desc: 'Singular label for a beauty center',
      args: [],
    );
  }

  /// `No centers available`
  String get noCenters {
    return Intl.message(
      'No centers available',
      name: 'noCenters',
      desc: 'Message when no centers are available',
      args: [],
    );
  }

  /// `Add center`
  String get addCenter {
    return Intl.message(
      'Add center',
      name: 'addCenter',
      desc: 'Label for adding a new center',
      args: [],
    );
  }

  /// `Center name`
  String get centerName {
    return Intl.message(
      'Center name',
      name: 'centerName',
      desc: 'Label for the center name field',
      args: [],
    );
  }

  /// `Center location`
  String get centerLocation {
    return Intl.message(
      'Center location',
      name: 'centerLocation',
      desc: 'Label for the center location field',
      args: [],
    );
  }

  /// `Center phone number`
  String get centerPhoneNumber {
    return Intl.message(
      'Center phone number',
      name: 'centerPhoneNumber',
      desc: 'Label for the center phone number field',
      args: [],
    );
  }

  /// `Center description`
  String get centerDescription {
    return Intl.message(
      'Center description',
      name: 'centerDescription',
      desc: 'Label for the center description field',
      args: [],
    );
  }

  /// `Center image`
  String get centerImage {
    return Intl.message(
      'Center image',
      name: 'centerImage',
      desc: 'Label for the center image field',
      args: [],
    );
  }

  /// `My profile`
  String get myProfile {
    return Intl.message(
      'My profile',
      name: 'myProfile',
      desc: 'Label for the user profile section',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: 'Label for the settings menu',
      args: [],
    );
  }

  /// `Update username`
  String get updateUsername {
    return Intl.message(
      'Update username',
      name: 'updateUsername',
      desc: 'Label for updating the username',
      args: [],
    );
  }

  /// `Change password`
  String get changePassword {
    return Intl.message(
      'Change password',
      name: 'changePassword',
      desc: 'Label for changing the password',
      args: [],
    );
  }

  /// `Current password`
  String get currentPassword {
    return Intl.message(
      'Current password',
      name: 'currentPassword',
      desc: 'Label for the current password field',
      args: [],
    );
  }

  /// `New password`
  String get newPassword {
    return Intl.message(
      'New password',
      name: 'newPassword',
      desc: 'Label for the new password field',
      args: [],
    );
  }

  /// `Confirm password`
  String get confirmPassword {
    return Intl.message(
      'Confirm password',
      name: 'confirmPassword',
      desc: 'Label for the confirm password field',
      args: [],
    );
  }

  /// `Delete account`
  String get deleteAccount {
    return Intl.message(
      'Delete account',
      name: 'deleteAccount',
      desc: 'Label for deleting the account',
      args: [],
    );
  }

  /// `About the app`
  String get aboutApp {
    return Intl.message(
      'About the app',
      name: 'aboutApp',
      desc: 'Label for the about app section',
      args: [],
    );
  }

  /// `Log out`
  String get logout {
    return Intl.message(
      'Log out',
      name: 'logout',
      desc: 'Label for the logout button',
      args: [],
    );
  }

  /// `Profile`
  String get profileTab {
    return Intl.message(
      'Profile',
      name: 'profileTab',
      desc: 'Label for the profile tab',
      args: [],
    );
  }

  /// `Search`
  String get searchTab {
    return Intl.message(
      'Search',
      name: 'searchTab',
      desc: 'Label for the search tab',
      args: [],
    );
  }

  /// `Reset password`
  String get resetPassword {
    return Intl.message(
      'Reset password',
      name: 'resetPassword',
      desc: 'Label for resetting the password',
      args: [],
    );
  }

  /// `New username`
  String get newUsername {
    return Intl.message(
      'New username',
      name: 'newUsername',
      desc: 'Label for the new username field',
      args: [],
    );
  }

  /// `News`
  String get newsTab {
    return Intl.message(
      'News',
      name: 'newsTab',
      desc: 'Label for the news tab',
      args: [],
    );
  }

  /// `Home`
  String get homeTab {
    return Intl.message(
      'Home',
      name: 'homeTab',
      desc: 'Label for the home tab',
      args: [],
    );
  }

  /// `Admin dashboard`
  String get adminDashboard {
    return Intl.message(
      'Admin dashboard',
      name: 'adminDashboard',
      desc: 'Label for the admin dashboard',
      args: [],
    );
  }

  /// `Centers`
  String get adminCenters {
    return Intl.message(
      'Centers',
      name: 'adminCenters',
      desc: 'Label for admin centers section',
      args: [],
    );
  }

  /// `Reviews`
  String get adminReviews {
    return Intl.message(
      'Reviews',
      name: 'adminReviews',
      desc: 'Label for admin reviews section',
      args: [],
    );
  }

  /// `Pending reviews`
  String get pendingReviews {
    return Intl.message(
      'Pending reviews',
      name: 'pendingReviews',
      desc: 'Label for pending reviews',
      args: [],
    );
  }

  /// `No pending reviews`
  String get noPendingReviews {
    return Intl.message(
      'No pending reviews',
      name: 'noPendingReviews',
      desc: 'Message when no reviews are pending',
      args: [],
    );
  }

  /// `Pending`
  String get subCentersPending {
    return Intl.message(
      'Pending',
      name: 'subCentersPending',
      desc: 'Label for pending sub-centers',
      args: [],
    );
  }

  /// `Current`
  String get subCentersCurrent {
    return Intl.message(
      'Current',
      name: 'subCentersCurrent',
      desc: 'Label for current sub-centers',
      args: [],
    );
  }

  /// `Add new center`
  String get addNewCenter {
    return Intl.message(
      'Add new center',
      name: 'addNewCenter',
      desc: 'Label for adding a new center',
      args: [],
    );
  }

  /// `Reviews`
  String get reviews {
    return Intl.message(
      'Reviews',
      name: 'reviews',
      desc: 'Label for reviews section',
      args: [],
    );
  }

  /// `No reviews yet`
  String get noReviews {
    return Intl.message(
      'No reviews yet',
      name: 'noReviews',
      desc: 'Message when no reviews are available',
      args: [],
    );
  }

  /// `Write a review`
  String get writeAReview {
    return Intl.message(
      'Write a review',
      name: 'writeAReview',
      desc: 'Label for writing a review',
      args: [],
    );
  }

  /// `Pending`
  String get pending {
    return Intl.message(
      'Pending',
      name: 'pending',
      desc: 'Label for pending status',
      args: [],
    );
  }

  // skipped getter for the 'current' key

  /// `How was your experience?`
  String get howWasExperience {
    return Intl.message(
      'How was your experience?',
      name: 'howWasExperience',
      desc: 'Prompt for user experience feedback',
      args: [],
    );
  }

  /// `Your Review`
  String get yourReview {
    return Intl.message(
      'Your Review',
      name: 'yourReview',
      desc: 'Label for the user\'s review input field',
      args: [],
    );
  }

  /// `Write something about your visit`
  String get writeSomethingAboutVisit {
    return Intl.message(
      'Write something about your visit',
      name: 'writeSomethingAboutVisit',
      desc: 'Prompt for writing a review about the visit',
      args: [],
    );
  }

  /// `Submit Review`
  String get submitReview {
    return Intl.message(
      'Submit Review',
      name: 'submitReview',
      desc: 'Label for the submit review button',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
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
