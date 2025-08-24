import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'l10n_ar.dart';
import 'l10n_en.dart';
import 'l10n_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of S
/// returned by `S.of(context)`.
///
/// Applications need to include `S.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/l10n.dart';
///
/// return MaterialApp(
///   localizationsDelegates: S.localizationsDelegates,
///   supportedLocales: S.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the S.supportedLocales
/// property.
abstract class S {
  S(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static S? of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  static const LocalizationsDelegate<S> delegate = _SDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('es'),
  ];

  /// Welcome text for the onboarding screen
  ///
  /// In en, this message translates to:
  /// **'Discover the best beauty centers\nnear you'**
  String get onboardingWelcomeText;

  /// Label for the register button
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// Label for the login button
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// Text for creating a new account
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get createAccount;

  /// Welcome message for returning users
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get welcomeBack;

  /// Text for the login screen
  ///
  /// In en, this message translates to:
  /// **'Log in to your account'**
  String get loginText;

  /// Label for the email field
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Label for the password field
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Text for the forgot password link
  ///
  /// In en, this message translates to:
  /// **'Forgot your password?'**
  String get forgotPassword;

  /// Label for the remember me checkbox
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// Prompt for users without an account
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get dontHaveAccount;

  /// Text for creating a new account
  ///
  /// In en, this message translates to:
  /// **'Create your new account'**
  String get createNewAccount;

  /// Label for the full name field
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullName;

  /// Text for alternative login options
  ///
  /// In en, this message translates to:
  /// **'Or continue with'**
  String get orContinueWith;

  /// Prompt for users who already have an account
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get alreadyHaveAccount;

  /// Label for the search function
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// App title
  ///
  /// In en, this message translates to:
  /// **'Beauty Support'**
  String get beautySupport;

  /// Label for beauty centers
  ///
  /// In en, this message translates to:
  /// **'Centers'**
  String get centers;

  /// Singular label for a beauty center
  ///
  /// In en, this message translates to:
  /// **'Center'**
  String get center;

  /// Message when no centers are available
  ///
  /// In en, this message translates to:
  /// **'No centers available'**
  String get noCenters;

  /// Label for adding a new center
  ///
  /// In en, this message translates to:
  /// **'Add center'**
  String get addCenter;

  /// Label for the center name field
  ///
  /// In en, this message translates to:
  /// **'Center name'**
  String get centerName;

  /// Label for the center location field
  ///
  /// In en, this message translates to:
  /// **'Center location'**
  String get centerLocation;

  /// Label for the center phone number field
  ///
  /// In en, this message translates to:
  /// **'Center phone number'**
  String get centerPhoneNumber;

  /// Label for the center description field
  ///
  /// In en, this message translates to:
  /// **'Center description'**
  String get centerDescription;

  /// Label for the center image field
  ///
  /// In en, this message translates to:
  /// **'Center image'**
  String get centerImage;

  /// Label for the user profile section
  ///
  /// In en, this message translates to:
  /// **'My profile'**
  String get myProfile;

  /// Label for the settings menu
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Label for updating the username
  ///
  /// In en, this message translates to:
  /// **'Update username'**
  String get updateUsername;

  /// Label for changing the password
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get changePassword;

  /// Label for the current password field
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get currentPassword;

  /// Label for the new password field
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPassword;

  /// Label for the confirm password field
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// Label for deleting the account
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get deleteAccount;

  /// Label for the about app section
  ///
  /// In en, this message translates to:
  /// **'About the app'**
  String get aboutApp;

  /// Label for the logout button
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// Label for the profile tab
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTab;

  /// Label for the search tab
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchTab;

  /// Label for resetting the password
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get resetPassword;

  /// Label for the new username field
  ///
  /// In en, this message translates to:
  /// **'New username'**
  String get newUsername;

  /// Label for the news tab
  ///
  /// In en, this message translates to:
  /// **'News'**
  String get newsTab;

  /// Label for the home tab
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTab;

  /// Label for the admin dashboard
  ///
  /// In en, this message translates to:
  /// **'Admin dashboard'**
  String get adminDashboard;

  /// Label for admin centers section
  ///
  /// In en, this message translates to:
  /// **'Centers'**
  String get adminCenters;

  /// Label for admin reviews section
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get adminReviews;

  /// Label for pending reviews
  ///
  /// In en, this message translates to:
  /// **'Pending reviews'**
  String get pendingReviews;

  /// Message when no reviews are pending
  ///
  /// In en, this message translates to:
  /// **'No pending reviews'**
  String get noPendingReviews;

  /// Label for pending sub-centers
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get subCentersPending;

  /// Label for current sub-centers
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get subCentersCurrent;

  /// Label for adding a new center
  ///
  /// In en, this message translates to:
  /// **'Add new center'**
  String get addNewCenter;

  /// Label for reviews section
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews;

  /// Message when no reviews are available
  ///
  /// In en, this message translates to:
  /// **'No reviews yet'**
  String get noReviews;

  /// Label for writing a review
  ///
  /// In en, this message translates to:
  /// **'Write a review'**
  String get writeAReview;

  /// Label for pending status
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// Label for current status
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get current;

  /// Prompt for user experience feedback
  ///
  /// In en, this message translates to:
  /// **'How was your experience?'**
  String get howWasExperience;

  /// Label for the user's review input field
  ///
  /// In en, this message translates to:
  /// **'Your Review'**
  String get yourReview;

  /// Prompt for writing a review about the visit
  ///
  /// In en, this message translates to:
  /// **'Write something about your visit'**
  String get writeSomethingAboutVisit;

  /// Label for the submit review button
  ///
  /// In en, this message translates to:
  /// **'Submit Review'**
  String get submitReview;
}

class _SDelegate extends LocalizationsDelegate<S> {
  const _SDelegate();

  @override
  Future<S> load(Locale locale) {
    return SynchronousFuture<S>(lookupS(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_SDelegate old) => false;
}

S lookupS(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return SAr();
    case 'en':
      return SEn();
    case 'es':
      return SEs();
  }

  throw FlutterError(
    'S.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
