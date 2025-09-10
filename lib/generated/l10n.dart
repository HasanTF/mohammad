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

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: 'Label for the home screen button',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: 'Label for the search button',
      args: [],
    );
  }

  /// `Loading...`
  String get loading {
    return Intl.message(
      'Loading...',
      name: 'loading',
      desc: 'Text shown while content is loading',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: 'Generic error message',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: 'OK confirmation button',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: 'Cancel button',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message(
      'Retry',
      name: 'retry',
      desc: 'Retry button label',
      args: [],
    );
  }

  /// `Go Back`
  String get goback {
    return Intl.message(
      'Go Back',
      name: 'goback',
      desc: 'Button to go back to the previous screen',
      args: [],
    );
  }

  /// `Approve`
  String get approve {
    return Intl.message(
      'Approve',
      name: 'approve',
      desc: 'Button to approve an item',
      args: [],
    );
  }

  /// `Reject`
  String get reject {
    return Intl.message(
      'Reject',
      name: 'reject',
      desc: 'Button to reject an item',
      args: [],
    );
  }

  /// `Decline`
  String get decline {
    return Intl.message(
      'Decline',
      name: 'decline',
      desc: 'Button to decline an action',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: 'Delete button label',
      args: [],
    );
  }

  /// `Are you sure?`
  String get areyousure {
    return Intl.message(
      'Are you sure?',
      name: 'areyousure',
      desc: 'Confirmation dialog question',
      args: [],
    );
  }

  /// `E-Mail`
  String get email {
    return Intl.message(
      'E-Mail',
      name: 'email',
      desc: 'Email field label',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: 'Password field label',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmpassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmpassword',
      desc: 'Confirm password field label',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotpassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotpassword',
      desc: 'Forgot password link text',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: 'Login button label',
      args: [],
    );
  }

  /// `Login with Apple`
  String get loginapple {
    return Intl.message(
      'Login with Apple',
      name: 'loginapple',
      desc: 'Login with Apple button',
      args: [],
    );
  }

  /// `Login with Google`
  String get logingoogle {
    return Intl.message(
      'Login with Google',
      name: 'logingoogle',
      desc: 'Login with Google button',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get noaccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'noaccount',
      desc: 'Prompt for users without an account',
      args: [],
    );
  }

  /// `Sign Up`
  String get signup {
    return Intl.message(
      'Sign Up',
      name: 'signup',
      desc: 'Sign up button label',
      args: [],
    );
  }

  /// `Let's create an account for you`
  String get letscreateaccount {
    return Intl.message(
      'Let\'s create an account for you',
      name: 'letscreateaccount',
      desc: 'Onboarding text for account creation',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: 'Username field label',
      args: [],
    );
  }

  /// `I agree to the Terms of Service & Privacy Policy`
  String get agreement {
    return Intl.message(
      'I agree to the Terms of Service & Privacy Policy',
      name: 'agreement',
      desc: 'Agreement text for terms and privacy',
      args: [],
    );
  }

  /// `This email is already registered`
  String get emailAlreadyInUse {
    return Intl.message(
      'This email is already registered',
      name: 'emailAlreadyInUse',
      desc: 'Error message shown when the email is already registered',
      args: [],
    );
  }

  /// `Invalid email format`
  String get invalidEmail {
    return Intl.message(
      'Invalid email format',
      name: 'invalidEmail',
      desc: 'Error message shown when the email format is invalid',
      args: [],
    );
  }

  /// `Password is too weak`
  String get weakPassword {
    return Intl.message(
      'Password is too weak',
      name: 'weakPassword',
      desc:
          'Error message shown when the password does not meet strength requirements',
      args: [],
    );
  }

  /// `Please enter your username`
  String get pleaseEnterUsername {
    return Intl.message(
      'Please enter your username',
      name: 'pleaseEnterUsername',
      desc: 'Validation message when username field is empty',
      args: [],
    );
  }

  /// `Username must be at least 3 characters`
  String get usernameTooShort {
    return Intl.message(
      'Username must be at least 3 characters',
      name: 'usernameTooShort',
      desc: 'Validation message when username is less than 3 characters',
      args: [],
    );
  }

  /// `Please confirm your password`
  String get pleaseConfirmPassword {
    return Intl.message(
      'Please confirm your password',
      name: 'pleaseConfirmPassword',
      desc: 'Validation message when confirm password field is empty',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordsDoNotMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordsDoNotMatch',
      desc:
          'Validation message when password and confirm password do not match',
      args: [],
    );
  }

  /// `Username`
  String get usernameLabel {
    return Intl.message(
      'Username',
      name: 'usernameLabel',
      desc: 'Label text for username input field',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPasswordLabel {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPasswordLabel',
      desc: 'Label text for confirm password input field',
      args: [],
    );
  }

  /// `CLINICLY`
  String get appName {
    return Intl.message(
      'CLINICLY',
      name: 'appName',
      desc: 'App name displayed in the header',
      args: [],
    );
  }

  /// `Let’s\nCreate Your\nAccount`
  String get createAccountHeader {
    return Intl.message(
      'Let’s\nCreate Your\nAccount',
      name: 'createAccountHeader',
      desc: 'Header text shown on the registration screen',
      args: [],
    );
  }

  /// `Please enter your email`
  String get pleaseEnterEmail {
    return Intl.message(
      'Please enter your email',
      name: 'pleaseEnterEmail',
      desc: 'Validation message when email field is empty',
      args: [],
    );
  }

  /// `Please enter a valid email address`
  String get invalidEmailAddress {
    return Intl.message(
      'Please enter a valid email address',
      name: 'invalidEmailAddress',
      desc: 'Validation message when email or phone is not valid',
      args: [],
    );
  }

  /// `Please enter your password`
  String get pleaseEnterPassword {
    return Intl.message(
      'Please enter your password',
      name: 'pleaseEnterPassword',
      desc: 'Validation message when password field is empty',
      args: [],
    );
  }

  /// `Password must be at least 6 characters`
  String get passwordTooShort {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'passwordTooShort',
      desc: 'Validation message when password is shorter than 6 characters',
      args: [],
    );
  }

  /// `No account found with this email or phone`
  String get noAccountFound {
    return Intl.message(
      'No account found with this email or phone',
      name: 'noAccountFound',
      desc: 'Error message when user does not exist in Firebase',
      args: [],
    );
  }

  /// `Incorrect password`
  String get incorrectPassword {
    return Intl.message(
      'Incorrect password',
      name: 'incorrectPassword',
      desc: 'Error message when user enters wrong password',
      args: [],
    );
  }

  /// `Invalid email or phone format`
  String get invalidEmailOrPhoneFormat {
    return Intl.message(
      'Invalid email or phone format',
      name: 'invalidEmailOrPhoneFormat',
      desc: 'Error message when email or phone format is invalid',
      args: [],
    );
  }

  /// `Too many attempts. Please try again later`
  String get tooManyAttempts {
    return Intl.message(
      'Too many attempts. Please try again later',
      name: 'tooManyAttempts',
      desc: 'Error message when too many login attempts are made',
      args: [],
    );
  }

  /// `This account has been disabled`
  String get accountDisabled {
    return Intl.message(
      'This account has been disabled',
      name: 'accountDisabled',
      desc: 'Error message when the account is disabled by an administrator',
      args: [],
    );
  }

  /// `Email`
  String get emailLabel {
    return Intl.message(
      'Email',
      name: 'emailLabel',
      desc: 'Label text for email input field',
      args: [],
    );
  }

  /// `Password`
  String get passwordLabel {
    return Intl.message(
      'Password',
      name: 'passwordLabel',
      desc: 'Label text for password input field',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: 'Clickable text for navigating to password reset screen',
      args: [],
    );
  }

  /// `Login`
  String get loginButton {
    return Intl.message(
      'Login',
      name: 'loginButton',
      desc: 'Text for login button',
      args: [],
    );
  }

  /// `Or`
  String get orText {
    return Intl.message(
      'Or',
      name: 'orText',
      desc: 'Separator text between login options',
      args: [],
    );
  }

  /// `Apple Sign-In Disabled`
  String get appleSignInDisabledTitle {
    return Intl.message(
      'Apple Sign-In Disabled',
      name: 'appleSignInDisabledTitle',
      desc: 'Dialog title when Apple login is disabled',
      args: [],
    );
  }

  /// `Apple Sign-In is currently disabled for this demo.`
  String get appleSignInDisabledMessage {
    return Intl.message(
      'Apple Sign-In is currently disabled for this demo.',
      name: 'appleSignInDisabledMessage',
      desc: 'Dialog message when Apple login is disabled',
      args: [],
    );
  }

  /// `Google Sign-In Disabled`
  String get googleSignInDisabledTitle {
    return Intl.message(
      'Google Sign-In Disabled',
      name: 'googleSignInDisabledTitle',
      desc: 'Dialog title when Google login is disabled',
      args: [],
    );
  }

  /// `Google Sign-In is currently disabled for this demo.`
  String get googleSignInDisabledMessage {
    return Intl.message(
      'Google Sign-In is currently disabled for this demo.',
      name: 'googleSignInDisabledMessage',
      desc: 'Dialog message when Google login is disabled',
      args: [],
    );
  }

  /// `OK`
  String get okButton {
    return Intl.message(
      'OK',
      name: 'okButton',
      desc: 'Text for confirming dialog',
      args: [],
    );
  }

  /// `Login with Apple`
  String get loginWithApple {
    return Intl.message(
      'Login with Apple',
      name: 'loginWithApple',
      desc: 'Button text for Apple sign-in option',
      args: [],
    );
  }

  /// `Login with Google`
  String get loginWithGoogle {
    return Intl.message(
      'Login with Google',
      name: 'loginWithGoogle',
      desc: 'Button text for Google sign-in option',
      args: [],
    );
  }

  /// `Dont have an account? `
  String get dontHaveAccount {
    return Intl.message(
      'Dont have an account? ',
      name: 'dontHaveAccount',
      desc: 'Text shown before the signup link',
      args: [],
    );
  }

  /// `Signup`
  String get signupText {
    return Intl.message(
      'Signup',
      name: 'signupText',
      desc: 'Clickable text to navigate to signup screen',
      args: [],
    );
  }

  /// `Too many attempts. Please try again later`
  String get tooManyRequests {
    return Intl.message(
      'Too many attempts. Please try again later',
      name: 'tooManyRequests',
      desc:
          'Error message shown when the user exceeds the allowed number of attempts',
      args: [],
    );
  }

  /// `An error occurred. Please try again`
  String get genericError {
    return Intl.message(
      'An error occurred. Please try again',
      name: 'genericError',
      desc: 'Generic error message shown when registration fails',
      args: [],
    );
  }

  /// `Already have an account? `
  String get alreadyhaveaccount {
    return Intl.message(
      'Already have an account? ',
      name: 'alreadyhaveaccount',
      desc: 'Prompt for users who already have an account',
      args: [],
    );
  }

  /// `Welcome back!`
  String get welcome {
    return Intl.message(
      'Welcome back!',
      name: 'welcome',
      desc: 'Welcome back message after login',
      args: [],
    );
  }

  /// `User not logged in.`
  String get usernotlogged {
    return Intl.message(
      'User not logged in.',
      name: 'usernotlogged',
      desc: 'Message shown when the user is not logged in',
      args: [],
    );
  }

  /// `All fields are required.`
  String get allfieldsrequired {
    return Intl.message(
      'All fields are required.',
      name: 'allfieldsrequired',
      desc: 'Error shown when form fields are empty',
      args: [],
    );
  }

  /// `Passwords do not match.`
  String get passwordsdonotmatch {
    return Intl.message(
      'Passwords do not match.',
      name: 'passwordsdonotmatch',
      desc: 'Error when password and confirm password do not match',
      args: [],
    );
  }

  /// `Password does not match.`
  String get passworddontmatch {
    return Intl.message(
      'Password does not match.',
      name: 'passworddontmatch',
      desc: 'Error when entered password is incorrect',
      args: [],
    );
  }

  /// `Password is too short.`
  String get passwordisshort {
    return Intl.message(
      'Password is too short.',
      name: 'passwordisshort',
      desc: 'Error when password length is too short',
      args: [],
    );
  }

  /// `Password successfully changed.`
  String get passwordsuccessfullychanged {
    return Intl.message(
      'Password successfully changed.',
      name: 'passwordsuccessfullychanged',
      desc: 'Success message for password change',
      args: [],
    );
  }

  /// `Enter your new password`
  String get enternewpassword {
    return Intl.message(
      'Enter your new password',
      name: 'enternewpassword',
      desc: 'Instruction to enter a new password',
      args: [],
    );
  }

  /// `Current Password`
  String get currentpassword {
    return Intl.message(
      'Current Password',
      name: 'currentpassword',
      desc: 'Label for current password field',
      args: [],
    );
  }

  /// `New Password`
  String get newpassword {
    return Intl.message(
      'New Password',
      name: 'newpassword',
      desc: 'Label for new password field',
      args: [],
    );
  }

  /// `Confirm New Password`
  String get confirmnewpassword {
    return Intl.message(
      'Confirm New Password',
      name: 'confirmnewpassword',
      desc: 'Label for confirm new password field',
      args: [],
    );
  }

  /// `Update Password`
  String get updatepassword {
    return Intl.message(
      'Update Password',
      name: 'updatepassword',
      desc: 'Button to update password',
      args: [],
    );
  }

  /// `Change Your Password`
  String get changeyourpassword {
    return Intl.message(
      'Change Your Password',
      name: 'changeyourpassword',
      desc: 'Title for change password screen',
      args: [],
    );
  }

  /// `Check your email for password reset instructions.`
  String get checkemail {
    return Intl.message(
      'Check your email for password reset instructions.',
      name: 'checkemail',
      desc: 'Instruction to check email for reset link',
      args: [],
    );
  }

  /// `An error occurred while resetting the password.`
  String get passwordreseterror {
    return Intl.message(
      'An error occurred while resetting the password.',
      name: 'passwordreseterror',
      desc: 'Error message for password reset',
      args: [],
    );
  }

  /// `An unexpected error occurred. Please try again.`
  String get unexpectederror {
    return Intl.message(
      'An unexpected error occurred. Please try again.',
      name: 'unexpectederror',
      desc: 'Generic unexpected error message',
      args: [],
    );
  }

  /// `Forgot Password`
  String get forgotpasswordpage {
    return Intl.message(
      'Forgot Password',
      name: 'forgotpasswordpage',
      desc: 'Title for forgot password screen',
      args: [],
    );
  }

  /// `Enter your email address to receive\npassword reset instructions.`
  String get enteremailreset {
    return Intl.message(
      'Enter your email address to receive\npassword reset instructions.',
      name: 'enteremailreset',
      desc: 'Instruction for entering email to reset password',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetpassword {
    return Intl.message(
      'Reset Password',
      name: 'resetpassword',
      desc: 'Button to reset password',
      args: [],
    );
  }

  /// `Please log in again to continue.`
  String get relogin {
    return Intl.message(
      'Please log in again to continue.',
      name: 'relogin',
      desc: 'Instruction to re-login after password change',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: 'Profile tab label',
      args: [],
    );
  }

  /// `My Profile`
  String get myprofile {
    return Intl.message(
      'My Profile',
      name: 'myprofile',
      desc: 'Label for user\'s profile',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: 'Settings tab label',
      args: [],
    );
  }

  /// `Update Username`
  String get updateusername {
    return Intl.message(
      'Update Username',
      name: 'updateusername',
      desc: 'Button to update username',
      args: [],
    );
  }

  /// `Enter your new username\nto update your profile and reviews`
  String get enternewusername {
    return Intl.message(
      'Enter your new username\nto update your profile and reviews',
      name: 'enternewusername',
      desc: 'Instruction to enter a new username',
      args: [],
    );
  }

  /// `New Username`
  String get newusername {
    return Intl.message(
      'New Username',
      name: 'newusername',
      desc: 'Label for new username field',
      args: [],
    );
  }

  /// `Username updated successfully.`
  String get usernameupdated {
    return Intl.message(
      'Username updated successfully.',
      name: 'usernameupdated',
      desc: 'Success message for username update',
      args: [],
    );
  }

  /// `Delete your account`
  String get deleteaccount {
    return Intl.message(
      'Delete your account',
      name: 'deleteaccount',
      desc: 'Button to delete account',
      args: [],
    );
  }

  /// `Enter your email and password to\ndelete your account permanently.`
  String get entertodelete {
    return Intl.message(
      'Enter your email and password to\ndelete your account permanently.',
      name: 'entertodelete',
      desc: 'Instruction to confirm account deletion',
      args: [],
    );
  }

  /// `Account deleted successfully.`
  String get accountdeleted {
    return Intl.message(
      'Account deleted successfully.',
      name: 'accountdeleted',
      desc: 'Success message after account deletion',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: 'Logout button label',
      args: [],
    );
  }

  /// `Confirm Logout`
  String get confirmlogout {
    return Intl.message(
      'Confirm Logout',
      name: 'confirmlogout',
      desc: 'Title for confirm logout dialog',
      args: [],
    );
  }

  /// `Are you sure you want to logout?`
  String get confirmlogoutmsg {
    return Intl.message(
      'Are you sure you want to logout?',
      name: 'confirmlogoutmsg',
      desc: 'Confirmation message for logout',
      args: [],
    );
  }

  /// `Clinics`
  String get clinics {
    return Intl.message(
      'Clinics',
      name: 'clinics',
      desc: 'Clinics section label',
      args: [],
    );
  }

  /// `Clinicly`
  String get clinicly {
    return Intl.message(
      'Clinicly',
      name: 'clinicly',
      desc: 'App name / branding text',
      args: [],
    );
  }

  /// `Add Clinic`
  String get addclinic {
    return Intl.message(
      'Add Clinic',
      name: 'addclinic',
      desc: 'Button to add a clinic',
      args: [],
    );
  }

  /// `Add New Clinic`
  String get addnewclinic {
    return Intl.message(
      'Add New Clinic',
      name: 'addnewclinic',
      desc: 'Title for adding a new clinic',
      args: [],
    );
  }

  /// `Clinic Name`
  String get clinicname {
    return Intl.message(
      'Clinic Name',
      name: 'clinicname',
      desc: 'Label for clinic name field',
      args: [],
    );
  }

  /// `Clinic Location`
  String get cliniclocation {
    return Intl.message(
      'Clinic Location',
      name: 'cliniclocation',
      desc: 'Label for clinic location field',
      args: [],
    );
  }

  /// `Clinic Phone Number`
  String get clinicphonenumber {
    return Intl.message(
      'Clinic Phone Number',
      name: 'clinicphonenumber',
      desc: 'Label for clinic phone number field',
      args: [],
    );
  }

  /// `Clinic Description`
  String get clinicdescription {
    return Intl.message(
      'Clinic Description',
      name: 'clinicdescription',
      desc: 'Label for clinic description field',
      args: [],
    );
  }

  /// `Clinic Image`
  String get clinicimage {
    return Intl.message(
      'Clinic Image',
      name: 'clinicimage',
      desc: 'Label for clinic image upload',
      args: [],
    );
  }

  /// `Unknown Clinic`
  String get unknownclinic {
    return Intl.message(
      'Unknown Clinic',
      name: 'unknownclinic',
      desc: 'Fallback text for unknown clinic',
      args: [],
    );
  }

  /// `Failed to add clinic. Please try again.`
  String get failedtoaddclinic {
    return Intl.message(
      'Failed to add clinic. Please try again.',
      name: 'failedtoaddclinic',
      desc: 'Error message when failing to add clinic',
      args: [],
    );
  }

  /// `Please fill in all fields to add a clinic.`
  String get filltoaddclinic {
    return Intl.message(
      'Please fill in all fields to add a clinic.',
      name: 'filltoaddclinic',
      desc: 'Instruction to complete clinic form',
      args: [],
    );
  }

  /// `No clinics found.`
  String get noclinicsfound {
    return Intl.message(
      'No clinics found.',
      name: 'noclinicsfound',
      desc: 'Message when no clinics are found',
      args: [],
    );
  }

  /// `No clinics available.`
  String get noclinics {
    return Intl.message(
      'No clinics available.',
      name: 'noclinics',
      desc: 'Message when no clinics are available',
      args: [],
    );
  }

  /// `Confirm Deletion`
  String get confirmdeletionclinic {
    return Intl.message(
      'Confirm Deletion',
      name: 'confirmdeletionclinic',
      desc: 'Title for confirm clinic deletion dialog',
      args: [],
    );
  }

  /// `Are you sure you want to delete this clinic?`
  String get confirmdeletionclinicmsg {
    return Intl.message(
      'Are you sure you want to delete this clinic?',
      name: 'confirmdeletionclinicmsg',
      desc: 'Confirmation message for clinic deletion',
      args: [],
    );
  }

  /// `Invalid clinic ID.`
  String get invalidclinicid {
    return Intl.message(
      'Invalid clinic ID.',
      name: 'invalidclinicid',
      desc: 'Error for invalid clinic ID',
      args: [],
    );
  }

  /// `Clinic rejected`
  String get clinicrejected {
    return Intl.message(
      'Clinic rejected',
      name: 'clinicrejected',
      desc: 'Message when clinic is rejected',
      args: [],
    );
  }

  /// `Services`
  String get services {
    return Intl.message(
      'Services',
      name: 'services',
      desc: 'Services section label',
      args: [],
    );
  }

  /// `Haircut`
  String get haircut {
    return Intl.message(
      'Haircut',
      name: 'haircut',
      desc: 'Service option for haircut',
      args: [],
    );
  }

  /// `Makeup`
  String get makeup {
    return Intl.message(
      'Makeup',
      name: 'makeup',
      desc: 'Service option for makeup',
      args: [],
    );
  }

  /// `Massage`
  String get massage {
    return Intl.message(
      'Massage',
      name: 'massage',
      desc: 'Service option for massage',
      args: [],
    );
  }

  /// `Nails`
  String get nails {
    return Intl.message(
      'Nails',
      name: 'nails',
      desc: 'Service option for nails',
      args: [],
    );
  }

  /// `Skincare`
  String get skincare {
    return Intl.message(
      'Skincare',
      name: 'skincare',
      desc: 'Service option for skincare',
      args: [],
    );
  }

  /// `Offers`
  String get offers {
    return Intl.message(
      'Offers',
      name: 'offers',
      desc: 'Offers section label',
      args: [],
    );
  }

  /// `Hot Offers`
  String get hotoffers {
    return Intl.message(
      'Hot Offers',
      name: 'hotoffers',
      desc: 'Label for hot offers section',
      args: [],
    );
  }

  /// `Favorites`
  String get favorites {
    return Intl.message(
      'Favorites',
      name: 'favorites',
      desc: 'Favorites section label',
      args: [],
    );
  }

  /// `My Favorites`
  String get myfavorites {
    return Intl.message(
      'My Favorites',
      name: 'myfavorites',
      desc: 'User\'s favorites list',
      args: [],
    );
  }

  /// `No favorites yet.`
  String get nofavorites {
    return Intl.message(
      'No favorites yet.',
      name: 'nofavorites',
      desc: 'Message when no favorites are available',
      args: [],
    );
  }

  /// `Removed from favorites`
  String get removedfromfavorites {
    return Intl.message(
      'Removed from favorites',
      name: 'removedfromfavorites',
      desc: 'Message when item removed from favorites',
      args: [],
    );
  }

  /// `Added to favorites`
  String get addedtofavorites {
    return Intl.message(
      'Added to favorites',
      name: 'addedtofavorites',
      desc: 'Message when item added to favorites',
      args: [],
    );
  }

  /// `Coming Soon`
  String get comingsoon {
    return Intl.message(
      'Coming Soon',
      name: 'comingsoon',
      desc: 'Label for upcoming features',
      args: [],
    );
  }

  /// `Reviews`
  String get reviews {
    return Intl.message(
      'Reviews',
      name: 'reviews',
      desc: 'Reviews section label',
      args: [],
    );
  }

  /// `No Reviews Yet`
  String get noreviews {
    return Intl.message(
      'No Reviews Yet',
      name: 'noreviews',
      desc: 'Message when no reviews exist',
      args: [],
    );
  }

  /// `Write a Review`
  String get writereview {
    return Intl.message(
      'Write a Review',
      name: 'writereview',
      desc: 'Button to write a new review',
      args: [],
    );
  }

  /// `Tell us about your experience with this clinic.`
  String get tellusexperience {
    return Intl.message(
      'Tell us about your experience with this clinic.',
      name: 'tellusexperience',
      desc: 'Prompt to share experience in review',
      args: [],
    );
  }

  /// `Your Rating`
  String get yourrating {
    return Intl.message(
      'Your Rating',
      name: 'yourrating',
      desc: 'Label for rating selection',
      args: [],
    );
  }

  /// `Please rate your experience`
  String get pleaserate {
    return Intl.message(
      'Please rate your experience',
      name: 'pleaserate',
      desc: 'Prompt asking user to rate',
      args: [],
    );
  }

  /// `Write your review here...`
  String get writereviewhere {
    return Intl.message(
      'Write your review here...',
      name: 'writereviewhere',
      desc: 'Placeholder for review input field',
      args: [],
    );
  }

  /// `Submit Review`
  String get submitreview {
    return Intl.message(
      'Submit Review',
      name: 'submitreview',
      desc: 'Button to submit review',
      args: [],
    );
  }

  /// `Failed to resubmit review.`
  String get failedtoresubmitreview {
    return Intl.message(
      'Failed to resubmit review.',
      name: 'failedtoresubmitreview',
      desc: 'Error when failing to resubmit review',
      args: [],
    );
  }

  /// `Please select a rating and write a review.`
  String get pleaseselectrating {
    return Intl.message(
      'Please select a rating and write a review.',
      name: 'pleaseselectrating',
      desc: 'Error when review is incomplete',
      args: [],
    );
  }

  /// `You must be logged in to submit a review.`
  String get mustbelogged {
    return Intl.message(
      'You must be logged in to submit a review.',
      name: 'mustbelogged',
      desc: 'Error when user not logged in tries to review',
      args: [],
    );
  }

  /// `Review submitted successfully!\nIt will appear once the admin approves it.`
  String get reviewsubmitted {
    return Intl.message(
      'Review submitted successfully!\nIt will appear once the admin approves it.',
      name: 'reviewsubmitted',
      desc: 'Success message after submitting review',
      args: [],
    );
  }

  /// `Failed to submit review. Please try again.`
  String get reviewnotsubmitted {
    return Intl.message(
      'Failed to submit review. Please try again.',
      name: 'reviewnotsubmitted',
      desc: 'Error when failing to submit review',
      args: [],
    );
  }

  /// `Your review has been resubmitted for admin approval.`
  String get resubmittedforapproval {
    return Intl.message(
      'Your review has been resubmitted for admin approval.',
      name: 'resubmittedforapproval',
      desc: 'Message when review is resubmitted',
      args: [],
    );
  }

  /// `Edit and resubmit your review.`
  String get editandresubmit {
    return Intl.message(
      'Edit and resubmit your review.',
      name: 'editandresubmit',
      desc: 'Instruction to edit and resubmit review',
      args: [],
    );
  }

  /// `Edit Review`
  String get editreview {
    return Intl.message(
      'Edit Review',
      name: 'editreview',
      desc: 'Button to edit review',
      args: [],
    );
  }

  /// `Resubmit your review for admin approval`
  String get resubmitforapproval {
    return Intl.message(
      'Resubmit your review for admin approval',
      name: 'resubmitforapproval',
      desc: 'Instruction to resubmit review for approval',
      args: [],
    );
  }

  /// `Rejected for: `
  String get rejectionreason {
    return Intl.message(
      'Rejected for: ',
      name: 'rejectionreason',
      desc: 'Label for rejection reason',
      args: [],
    );
  }

  /// `Your Review`
  String get yourreview {
    return Intl.message(
      'Your Review',
      name: 'yourreview',
      desc: 'Label for user\'s review',
      args: [],
    );
  }

  /// `Resubmit Review`
  String get resubmitreview {
    return Intl.message(
      'Resubmit Review',
      name: 'resubmitreview',
      desc: 'Button to resubmit review',
      args: [],
    );
  }

  /// `Deleting review...`
  String get deletingreview {
    return Intl.message(
      'Deleting review...',
      name: 'deletingreview',
      desc: 'Message shown while deleting review',
      args: [],
    );
  }

  /// `Review deleted successfully.`
  String get reviewdeleted {
    return Intl.message(
      'Review deleted successfully.',
      name: 'reviewdeleted',
      desc: 'Success message after deleting review',
      args: [],
    );
  }

  /// `Failed to delete review`
  String get failedtodeletereview {
    return Intl.message(
      'Failed to delete review',
      name: 'failedtodeletereview',
      desc: 'Error message when failing to delete review',
      args: [],
    );
  }

  /// `Confirm Deleting`
  String get confirmdeleting {
    return Intl.message(
      'Confirm Deleting',
      name: 'confirmdeleting',
      desc: 'Title for confirm deleting dialog',
      args: [],
    );
  }

  /// `Are you sure you want to delete this review?`
  String get confirmdeletingmsg {
    return Intl.message(
      'Are you sure you want to delete this review?',
      name: 'confirmdeletingmsg',
      desc: 'Confirmation message for review deletion',
      args: [],
    );
  }

  /// `Delete Review`
  String get deletereview {
    return Intl.message(
      'Delete Review',
      name: 'deletereview',
      desc: 'Button to delete review',
      args: [],
    );
  }

  /// `Admin Panel`
  String get adminpanel {
    return Intl.message(
      'Admin Panel',
      name: 'adminpanel',
      desc: 'Label for admin panel section',
      args: [],
    );
  }

  /// `Pending Reviews`
  String get pendingreviews {
    return Intl.message(
      'Pending Reviews',
      name: 'pendingreviews',
      desc: 'Label for pending reviews section',
      args: [],
    );
  }

  /// `No pending reviews.`
  String get nopendingreviews {
    return Intl.message(
      'No pending reviews.',
      name: 'nopendingreviews',
      desc: 'Message when no pending reviews exist',
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

  /// `Current`
  String get currents {
    return Intl.message(
      'Current',
      name: 'currents',
      desc: 'Label for current status',
      args: [],
    );
  }

  /// `About this App`
  String get aboutapp {
    return Intl.message(
      'About this App',
      name: 'aboutapp',
      desc: 'Label for about app section',
      args: [],
    );
  }

  /// `clinic approved`
  String get centerapproved {
    return Intl.message(
      'clinic approved',
      name: 'centerapproved',
      desc: 'Message when clinic is approved',
      args: [],
    );
  }

  /// `Error approving clinic`
  String get erroraprrovingcenter {
    return Intl.message(
      'Error approving clinic',
      name: 'erroraprrovingcenter',
      desc: 'Error message when failing to approve clinic',
      args: [],
    );
  }

  /// `Failed to approve clinic`
  String get failedtoapprovecenter {
    return Intl.message(
      'Failed to approve clinic',
      name: 'failedtoapprovecenter',
      desc: 'Failure message for clinic approval',
      args: [],
    );
  }

  /// `Do you really want to decline this clinic?\nThis action cannot be undone.`
  String get doyoureallywanttodecline {
    return Intl.message(
      'Do you really want to decline this clinic?\nThis action cannot be undone.',
      name: 'doyoureallywanttodecline',
      desc: 'Confirmation to decline a clinic',
      args: [],
    );
  }

  /// `clinic rejected`
  String get centerrejected {
    return Intl.message(
      'clinic rejected',
      name: 'centerrejected',
      desc: 'Message when clinic is rejected',
      args: [],
    );
  }

  /// `Error rejecting clinic`
  String get errorrejectingcenter {
    return Intl.message(
      'Error rejecting clinic',
      name: 'errorrejectingcenter',
      desc: 'Error message for rejecting clinic',
      args: [],
    );
  }

  /// `Failed to reject clinic`
  String get failedtorejectcenter {
    return Intl.message(
      'Failed to reject clinic',
      name: 'failedtorejectcenter',
      desc: 'Failure message for rejecting clinic',
      args: [],
    );
  }

  /// `Are you sure you want to\ndelete this review?`
  String get confirmdeletingreview {
    return Intl.message(
      'Are you sure you want to\ndelete this review?',
      name: 'confirmdeletingreview',
      desc: 'Confirmation message for deleting a review',
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
