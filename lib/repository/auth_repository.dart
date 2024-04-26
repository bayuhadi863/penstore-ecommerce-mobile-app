import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository extends GetxController {
  static AuthRepository get instance => Get.find();

  // @override
  // void onReady() {
  //   // super.onReady();
  //   screenRedirect();
  // }

  // Function to show relevant screen
  // screenRedirect() async {
  //   if (FirebaseAuth.instance.currentUser != null) {
  //     print(FirebaseAuth.instance.currentUser);
  //     Get.offAllNamed('/');
  //   } else {
  //     Get.offAllNamed('/login');
  //   }
  // }

  // Firebase email sign in
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw e.code;
    } on FirebaseException catch (e) {
      throw e.code;
    } on FormatException catch (_) {
      throw 'Format Exeption Error';
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Firebase email sign up
  Future<User?> signUpWithEmail(String email, String password) async {
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw e.code;
    } on FirebaseException catch (e) {
      throw e.code;
    } on FormatException catch (_) {
      throw 'Format Exeption Error';
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Firebase email verification
  Future<void> sendEmailVerification() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      await user!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw e.code;
    } on FirebaseException catch (e) {
      throw e.code;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Firebase sign out
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAllNamed('/login');
    } on FirebaseAuthException catch (e) {
      throw e.code;
    } on FirebaseException catch (e) {
      throw e.code;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
