import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

ValueNotifier<AuthSevices> authServices = ValueNotifier(AuthSevices());

class AuthSevices {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn.instance;

  User? get currentUser => firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  Future<UserCredential?> signInWithGoogle() async {
    try {
      await googleSignIn.disconnect();

      await googleSignIn.initialize(
        serverClientId:
            "904006621832-2fl15ko7u886rjh3j2usfni3uu8iform.apps.googleusercontent.com",
      );

      final account = await googleSignIn.authenticate();

      final auth = account.authentication;
      final credentials = GoogleAuthProvider.credential(idToken: auth.idToken);

      final userCredential = await firebaseAuth.signInWithCredential(
        credentials,
      );
      final user = userCredential.user;

      if (user != null) {
        // تحديث displayName في FirebaseAuth إذا كان موجودًا
        final displayName = user.displayName ?? "User";
        await user.updateDisplayName(displayName);

        // التحقق إذا كان المستخدم موجود في Firestore، وإذا لأ، إضافته
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (!userDoc.exists) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
                'uid': user.uid,
                'email': user.email ?? '',
                'username': displayName,
                'name': displayName,
                'imageUrl': user.photoURL ?? '',
                'isAdmin': false,
                'createdAt': FieldValue.serverTimestamp(),
              });
        }
      }

      debugPrint("✅ Google Sign-In successful!");
      debugPrint("User UID: ${userCredential.user?.uid}");
      debugPrint("User Email: ${userCredential.user?.email}");
      debugPrint("User Name: ${userCredential.user?.displayName}");
      debugPrint("User Credentials: $userCredential");

      return userCredential;
    } catch (e) {
      debugPrint("❌ Error during Google Sign-In: $e");
      return null;
    }
  }

  Future<UserCredential> signInWithApple() async {
    // Trigger the Sign in with Apple flow
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );

    return await firebaseAuth.signInWithCredential(oauthCredential);
  }

  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    return await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> createAccount({
    required String email,
    required String password,
    required String username,
    required String name,
    bool isAdmin = false,
    String? imageUrl,
  }) async {
    try {
      // إنشاء المستخدم في Firebase Authentication
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user;

      if (user != null) {
        // تحديث displayName في FirebaseAuth
        await user.updateDisplayName(name);

        // إضافة بيانات المستخدم في Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'email': email,
          'username': username,
          'name': name,
          'imageUrl': imageUrl ?? '',
          'isAdmin': isAdmin,
          'createdAt': FieldValue.serverTimestamp(),
        });

        // debugPrint(
        // "User data successfully added to Firestore for UID: ${user.uid}",
        // );
      }

      return userCredential;
    } catch (e) {
      // debugPrint("Error creating account: $e");
      rethrow; // لعرض الخطأ في مكان استدعاء الدالة
    }
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
    await googleSignIn.signOut();
  }

  Future<void> resetPassword({required String email}) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> updateUsername({required String username}) async {
    if (currentUser != null) {
      await currentUser!.updateDisplayName(username);
    }
  }

  Future<void> resetPasswordFromCurrentPassword({
    required String currentPassword,
    required String newPassword,
    required String email,
  }) async {
    AuthCredential credential = EmailAuthProvider.credential(
      email: email,
      password: currentPassword,
    );
    await currentUser!.reauthenticateWithCredential(credential);
    await currentUser!.updatePassword(newPassword);
  }

  Future<void> deleteAccount({
    required String email,
    required String password,
  }) async {
    AuthCredential credential = EmailAuthProvider.credential(
      email: email,
      password: password,
    );
    await currentUser!.reauthenticateWithCredential(credential);
    await currentUser!.delete();
    await firebaseAuth.signOut();
  }
}
