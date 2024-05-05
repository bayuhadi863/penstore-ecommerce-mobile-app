// ignore_for_file: use_rethrow_when_possible

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:penstore/models/user_model.dart';
import 'package:penstore/repository/user_repository.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  // User variable
  final Rx<UserModel> user = UserModel.empty().obs;

  // Current logged in user
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  void onInit() {
    super.onInit();
    getUser(currentUser!.uid);
  }

  // Get user by id
  void getUser(String uid) async {
    try {
      final userRepository = Get.put(UserRepository());
      final user = await userRepository.fetchUser(uid);
      this.user.value = user;
    } catch (e) {
      throw e;
    }
  }
}
