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

  /// Label for the home screen button
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Label for the search button
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// Text shown while content is loading
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Generic error message
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// OK confirmation button
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// Cancel button
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Retry button label
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Button to go back to the previous screen
  ///
  /// In en, this message translates to:
  /// **'Go Back'**
  String get goback;

  /// Button to approve an item
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get approve;

  /// Button to reject an item
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get reject;

  /// Button to decline an action
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get decline;

  /// Delete button label
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Confirmation dialog question
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get areyousure;

  /// Email field label
  ///
  /// In en, this message translates to:
  /// **'E-Mail'**
  String get email;

  /// Password field label
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Confirm password field label
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmpassword;

  /// Forgot password link text
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotpassword;

  /// Login button label
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// Login with Apple button
  ///
  /// In en, this message translates to:
  /// **'Login with Apple'**
  String get loginapple;

  /// Login with Google button
  ///
  /// In en, this message translates to:
  /// **'Login with Google'**
  String get logingoogle;

  /// Prompt for users without an account
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get noaccount;

  /// Sign up button label
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signup;

  /// Onboarding text for account creation
  ///
  /// In en, this message translates to:
  /// **'Let\'s create an account for you'**
  String get letscreateaccount;

  /// Username field label
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// Agreement text for terms and privacy
  ///
  /// In en, this message translates to:
  /// **'I agree to the Terms of Service & Privacy Policy'**
  String get agreement;

  /// Error message shown when the email is already registered
  ///
  /// In en, this message translates to:
  /// **'This email is already registered'**
  String get emailAlreadyInUse;

  /// Error message shown when the email format is invalid
  ///
  /// In en, this message translates to:
  /// **'Invalid email format'**
  String get invalidEmail;

  /// Error message shown when the password does not meet strength requirements
  ///
  /// In en, this message translates to:
  /// **'Password is too weak'**
  String get weakPassword;

  /// Validation message when username field is empty
  ///
  /// In en, this message translates to:
  /// **'Please enter your username'**
  String get pleaseEnterUsername;

  /// Validation message when username is less than 3 characters
  ///
  /// In en, this message translates to:
  /// **'Username must be at least 3 characters'**
  String get usernameTooShort;

  /// Validation message when confirm password field is empty
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get pleaseConfirmPassword;

  /// Validation message when password and confirm password do not match
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// Label text for username input field
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get usernameLabel;

  /// Label text for confirm password input field
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPasswordLabel;

  /// App name displayed in the header
  ///
  /// In en, this message translates to:
  /// **'CLINICLY'**
  String get appName;

  /// Header text shown on the registration screen
  ///
  /// In en, this message translates to:
  /// **'Let’s\nCreate Your\nAccount'**
  String get createAccountHeader;

  /// Validation message when email field is empty
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get pleaseEnterEmail;

  /// Validation message when email or phone is not valid
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get invalidEmailAddress;

  /// Validation message when password field is empty
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get pleaseEnterPassword;

  /// Validation message when password is shorter than 6 characters
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordTooShort;

  /// Error message when user does not exist in Firebase
  ///
  /// In en, this message translates to:
  /// **'No account found with this email or phone'**
  String get noAccountFound;

  /// Error message when user enters wrong password
  ///
  /// In en, this message translates to:
  /// **'Incorrect password'**
  String get incorrectPassword;

  /// Error message when email or phone format is invalid
  ///
  /// In en, this message translates to:
  /// **'Invalid email or phone format'**
  String get invalidEmailOrPhoneFormat;

  /// Error message when too many login attempts are made
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Please try again later'**
  String get tooManyAttempts;

  /// Error message when the account is disabled by an administrator
  ///
  /// In en, this message translates to:
  /// **'This account has been disabled'**
  String get accountDisabled;

  /// Label text for email input field
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// Label text for password input field
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// Clickable text for navigating to password reset screen
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// Text for login button
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// Separator text between login options
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get orText;

  /// Dialog title when Apple login is disabled
  ///
  /// In en, this message translates to:
  /// **'Apple Sign-In Disabled'**
  String get appleSignInDisabledTitle;

  /// Dialog message when Apple login is disabled
  ///
  /// In en, this message translates to:
  /// **'Apple Sign-In is currently disabled for this demo.'**
  String get appleSignInDisabledMessage;

  /// Dialog title when Google login is disabled
  ///
  /// In en, this message translates to:
  /// **'Google Sign-In Disabled'**
  String get googleSignInDisabledTitle;

  /// Dialog message when Google login is disabled
  ///
  /// In en, this message translates to:
  /// **'Google Sign-In is currently disabled for this demo.'**
  String get googleSignInDisabledMessage;

  /// Text for confirming dialog
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get okButton;

  /// Button text for Apple sign-in option
  ///
  /// In en, this message translates to:
  /// **'Login with Apple'**
  String get loginWithApple;

  /// Button text for Google sign-in option
  ///
  /// In en, this message translates to:
  /// **'Login with Google'**
  String get loginWithGoogle;

  /// Text shown before the signup link
  ///
  /// In en, this message translates to:
  /// **'Dont have an account? '**
  String get dontHaveAccount;

  /// Clickable text to navigate to signup screen
  ///
  /// In en, this message translates to:
  /// **'Signup'**
  String get signupText;

  /// Error message shown when the user exceeds the allowed number of attempts
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Please try again later'**
  String get tooManyRequests;

  /// Generic error message shown when registration fails
  ///
  /// In en, this message translates to:
  /// **'An error occurred. Please try again'**
  String get genericError;

  /// Prompt for users who already have an account
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get alreadyhaveaccount;

  /// Welcome back message after login
  ///
  /// In en, this message translates to:
  /// **'Welcome back!'**
  String get welcome;

  /// Message shown when the user is not logged in
  ///
  /// In en, this message translates to:
  /// **'User not logged in.'**
  String get usernotlogged;

  /// Error shown when form fields are empty
  ///
  /// In en, this message translates to:
  /// **'All fields are required.'**
  String get allfieldsrequired;

  /// Error when password and confirm password do not match
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get passwordsdonotmatch;

  /// Error when entered password is incorrect
  ///
  /// In en, this message translates to:
  /// **'Password does not match.'**
  String get passworddontmatch;

  /// Error when password length is too short
  ///
  /// In en, this message translates to:
  /// **'Password is too short.'**
  String get passwordisshort;

  /// Success message for password change
  ///
  /// In en, this message translates to:
  /// **'Password successfully changed.'**
  String get passwordsuccessfullychanged;

  /// Instruction to enter a new password
  ///
  /// In en, this message translates to:
  /// **'Enter your new password'**
  String get enternewpassword;

  /// Label for current password field
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get currentpassword;

  /// Label for new password field
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newpassword;

  /// Label for confirm new password field
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirmnewpassword;

  /// Button to update password
  ///
  /// In en, this message translates to:
  /// **'Update Password'**
  String get updatepassword;

  /// Title for change password screen
  ///
  /// In en, this message translates to:
  /// **'Change Your Password'**
  String get changeyourpassword;

  /// Instruction to check email for reset link
  ///
  /// In en, this message translates to:
  /// **'Check your email for password reset instructions.'**
  String get checkemail;

  /// Error message for password reset
  ///
  /// In en, this message translates to:
  /// **'An error occurred while resetting the password.'**
  String get passwordreseterror;

  /// Generic unexpected error message
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred. Please try again.'**
  String get unexpectederror;

  /// Title for forgot password screen
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotpasswordpage;

  /// Instruction for entering email to reset password
  ///
  /// In en, this message translates to:
  /// **'Enter your email address to receive\npassword reset instructions.'**
  String get enteremailreset;

  /// Button to reset password
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetpassword;

  /// Instruction to re-login after password change
  ///
  /// In en, this message translates to:
  /// **'Please log in again to continue.'**
  String get relogin;

  /// Profile tab label
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// Label for user's profile
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get myprofile;

  /// Settings tab label
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Button to update username
  ///
  /// In en, this message translates to:
  /// **'Update Username'**
  String get updateusername;

  /// Instruction to enter a new username
  ///
  /// In en, this message translates to:
  /// **'Enter your new username\nto update your profile and reviews'**
  String get enternewusername;

  /// Label for new username field
  ///
  /// In en, this message translates to:
  /// **'New Username'**
  String get newusername;

  /// Success message for username update
  ///
  /// In en, this message translates to:
  /// **'Username updated successfully.'**
  String get usernameupdated;

  /// Button to delete account
  ///
  /// In en, this message translates to:
  /// **'Delete your account'**
  String get deleteaccount;

  /// Instruction to confirm account deletion
  ///
  /// In en, this message translates to:
  /// **'Enter your email and password to\ndelete your account permanently.'**
  String get entertodelete;

  /// Success message after account deletion
  ///
  /// In en, this message translates to:
  /// **'Account deleted successfully.'**
  String get accountdeleted;

  /// Logout button label
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// Title for confirm logout dialog
  ///
  /// In en, this message translates to:
  /// **'Confirm Logout'**
  String get confirmlogout;

  /// Confirmation message for logout
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get confirmlogoutmsg;

  /// Clinics section label
  ///
  /// In en, this message translates to:
  /// **'Clinics'**
  String get clinics;

  /// App name / branding text
  ///
  /// In en, this message translates to:
  /// **'Clinicly'**
  String get clinicly;

  /// Button to add a clinic
  ///
  /// In en, this message translates to:
  /// **'Add Clinic'**
  String get addclinic;

  /// Title for adding a new clinic
  ///
  /// In en, this message translates to:
  /// **'Add New Clinic'**
  String get addnewclinic;

  /// Label for clinic name field
  ///
  /// In en, this message translates to:
  /// **'Clinic Name'**
  String get clinicname;

  /// Label for clinic location field
  ///
  /// In en, this message translates to:
  /// **'Clinic Location'**
  String get cliniclocation;

  /// Label for clinic phone number field
  ///
  /// In en, this message translates to:
  /// **'Clinic Phone Number'**
  String get clinicphonenumber;

  /// Label for clinic description field
  ///
  /// In en, this message translates to:
  /// **'Clinic Description'**
  String get clinicdescription;

  /// Label for clinic image upload
  ///
  /// In en, this message translates to:
  /// **'Clinic Image'**
  String get clinicimage;

  /// Fallback text for unknown clinic
  ///
  /// In en, this message translates to:
  /// **'Unknown Clinic'**
  String get unknownclinic;

  /// Error message when failing to add clinic
  ///
  /// In en, this message translates to:
  /// **'Failed to add clinic. Please try again.'**
  String get failedtoaddclinic;

  /// Instruction to complete clinic form
  ///
  /// In en, this message translates to:
  /// **'Please fill in all fields to add a clinic.'**
  String get filltoaddclinic;

  /// Message when no clinics are found
  ///
  /// In en, this message translates to:
  /// **'No clinics found.'**
  String get noclinicsfound;

  /// Message when no clinics are available
  ///
  /// In en, this message translates to:
  /// **'No clinics available.'**
  String get noclinics;

  /// Title for confirm clinic deletion dialog
  ///
  /// In en, this message translates to:
  /// **'Confirm Deletion'**
  String get confirmdeletionclinic;

  /// Confirmation message for clinic deletion
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this clinic?'**
  String get confirmdeletionclinicmsg;

  /// Error for invalid clinic ID
  ///
  /// In en, this message translates to:
  /// **'Invalid clinic ID.'**
  String get invalidclinicid;

  /// Message when clinic is rejected
  ///
  /// In en, this message translates to:
  /// **'Clinic rejected'**
  String get clinicrejected;

  /// Services section label
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// Service option for haircut
  ///
  /// In en, this message translates to:
  /// **'Haircut'**
  String get haircut;

  /// Service option for makeup
  ///
  /// In en, this message translates to:
  /// **'Makeup'**
  String get makeup;

  /// Service option for massage
  ///
  /// In en, this message translates to:
  /// **'Massage'**
  String get massage;

  /// Service option for nails
  ///
  /// In en, this message translates to:
  /// **'Nails'**
  String get nails;

  /// Service option for skincare
  ///
  /// In en, this message translates to:
  /// **'Skincare'**
  String get skincare;

  /// Offers section label
  ///
  /// In en, this message translates to:
  /// **'Offers'**
  String get offers;

  /// Label for hot offers section
  ///
  /// In en, this message translates to:
  /// **'Hot Offers'**
  String get hotoffers;

  /// Favorites section label
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// User's favorites list
  ///
  /// In en, this message translates to:
  /// **'My Favorites'**
  String get myfavorites;

  /// Message when no favorites are available
  ///
  /// In en, this message translates to:
  /// **'No favorites yet.'**
  String get nofavorites;

  /// Message when item removed from favorites
  ///
  /// In en, this message translates to:
  /// **'Removed from favorites'**
  String get removedfromfavorites;

  /// Message when item added to favorites
  ///
  /// In en, this message translates to:
  /// **'Added to favorites'**
  String get addedtofavorites;

  /// Label for upcoming features
  ///
  /// In en, this message translates to:
  /// **'Coming Soon'**
  String get comingsoon;

  /// Reviews section label
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews;

  /// Message when no reviews exist
  ///
  /// In en, this message translates to:
  /// **'No Reviews Yet'**
  String get noreviews;

  /// Button to write a new review
  ///
  /// In en, this message translates to:
  /// **'Write a Review'**
  String get writereview;

  /// Prompt to share experience in review
  ///
  /// In en, this message translates to:
  /// **'Tell us about your experience with this clinic.'**
  String get tellusexperience;

  /// Label for rating selection
  ///
  /// In en, this message translates to:
  /// **'Your Rating'**
  String get yourrating;

  /// Prompt asking user to rate
  ///
  /// In en, this message translates to:
  /// **'Please rate your experience'**
  String get pleaserate;

  /// Placeholder for review input field
  ///
  /// In en, this message translates to:
  /// **'Write your review here...'**
  String get writereviewhere;

  /// Button to submit review
  ///
  /// In en, this message translates to:
  /// **'Submit Review'**
  String get submitreview;

  /// Error when failing to resubmit review
  ///
  /// In en, this message translates to:
  /// **'Failed to resubmit review.'**
  String get failedtoresubmitreview;

  /// Error when review is incomplete
  ///
  /// In en, this message translates to:
  /// **'Please select a rating and write a review.'**
  String get pleaseselectrating;

  /// Error when user not logged in tries to review
  ///
  /// In en, this message translates to:
  /// **'You must be logged in to submit a review.'**
  String get mustbelogged;

  /// Success message after submitting review
  ///
  /// In en, this message translates to:
  /// **'Review submitted successfully!\nIt will appear once the admin approves it.'**
  String get reviewsubmitted;

  /// Error when failing to submit review
  ///
  /// In en, this message translates to:
  /// **'Failed to submit review. Please try again.'**
  String get reviewnotsubmitted;

  /// Message when review is resubmitted
  ///
  /// In en, this message translates to:
  /// **'Your review has been resubmitted for admin approval.'**
  String get resubmittedforapproval;

  /// Instruction to edit and resubmit review
  ///
  /// In en, this message translates to:
  /// **'Edit and resubmit your review.'**
  String get editandresubmit;

  /// Button to edit review
  ///
  /// In en, this message translates to:
  /// **'Edit Review'**
  String get editreview;

  /// Instruction to resubmit review for approval
  ///
  /// In en, this message translates to:
  /// **'Resubmit your review for admin approval'**
  String get resubmitforapproval;

  /// Label for rejection reason
  ///
  /// In en, this message translates to:
  /// **'Rejected for: '**
  String get rejectionreason;

  /// Label for user's review
  ///
  /// In en, this message translates to:
  /// **'Your Review'**
  String get yourreview;

  /// Button to resubmit review
  ///
  /// In en, this message translates to:
  /// **'Resubmit Review'**
  String get resubmitreview;

  /// Message shown while deleting review
  ///
  /// In en, this message translates to:
  /// **'Deleting review...'**
  String get deletingreview;

  /// Success message after deleting review
  ///
  /// In en, this message translates to:
  /// **'Review deleted successfully.'**
  String get reviewdeleted;

  /// Error message when failing to delete review
  ///
  /// In en, this message translates to:
  /// **'Failed to delete review'**
  String get failedtodeletereview;

  /// Title for confirm deleting dialog
  ///
  /// In en, this message translates to:
  /// **'Confirm Deleting'**
  String get confirmdeleting;

  /// Confirmation message for review deletion
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this review?'**
  String get confirmdeletingmsg;

  /// Button to delete review
  ///
  /// In en, this message translates to:
  /// **'Delete Review'**
  String get deletereview;

  /// Label for admin panel section
  ///
  /// In en, this message translates to:
  /// **'Admin Panel'**
  String get adminpanel;

  /// Label for pending reviews section
  ///
  /// In en, this message translates to:
  /// **'Pending Reviews'**
  String get pendingreviews;

  /// Message when no pending reviews exist
  ///
  /// In en, this message translates to:
  /// **'No pending reviews.'**
  String get nopendingreviews;

  /// Label for pending status
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// Label for current status
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get currents;

  /// Label for about app section
  ///
  /// In en, this message translates to:
  /// **'About this App'**
  String get aboutapp;

  /// Message when clinic is approved
  ///
  /// In en, this message translates to:
  /// **'clinic approved'**
  String get centerapproved;

  /// Error message when failing to approve clinic
  ///
  /// In en, this message translates to:
  /// **'Error approving clinic'**
  String get erroraprrovingcenter;

  /// Failure message for clinic approval
  ///
  /// In en, this message translates to:
  /// **'Failed to approve clinic'**
  String get failedtoapprovecenter;

  /// Confirmation to decline a clinic
  ///
  /// In en, this message translates to:
  /// **'Do you really want to decline this clinic?\nThis action cannot be undone.'**
  String get doyoureallywanttodecline;

  /// Message when clinic is rejected
  ///
  /// In en, this message translates to:
  /// **'clinic rejected'**
  String get centerrejected;

  /// Error message for rejecting clinic
  ///
  /// In en, this message translates to:
  /// **'Error rejecting clinic'**
  String get errorrejectingcenter;

  /// Failure message for rejecting clinic
  ///
  /// In en, this message translates to:
  /// **'Failed to reject clinic'**
  String get failedtorejectcenter;

  /// Confirmation message for deleting a review
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to\ndelete this review?'**
  String get confirmdeletingreview;
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
