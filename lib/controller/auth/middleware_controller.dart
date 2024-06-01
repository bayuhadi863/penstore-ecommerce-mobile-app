import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:penstore/models/user_model.dart';
import 'package:penstore/repository/user_repository.dart';

class MiddlewareController extends GetxController {
  static MiddlewareController get to => Get.find();

  final RxBool isLoading = false.obs;
  final Rx<UserModel> user = UserModel.empty().obs;

  final authUser = FirebaseAuth.instance.currentUser;

  @override
  void onInit() {
    super.onInit();
    screenRedirect();
  }

  Future<UserModel> getCurrentUser() async {
    try {
      final UserRepository userRepository = Get.put(UserRepository());
      final user = await userRepository.fetchUser(authUser!.uid);

      return user;
    } catch (e) {
      isLoading(false);
      throw e.toString();
    }
  }

  void screenRedirect() async {
    if (authUser != null) {
      final user = await getCurrentUser();
      if (user.isAdmin == true) {
        Get.offAllNamed('/admin');
      } else {
        Get.offAllNamed('/');
      }
    } else {
      Get.offAllNamed('/login');
    }
  }
}
