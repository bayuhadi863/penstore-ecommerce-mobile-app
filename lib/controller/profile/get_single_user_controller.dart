// ignore_for_file: use_rethrow_when_possible

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:penstore/models/user_model.dart';
import 'package:penstore/repository/user_repository.dart';

class GetSingleUserController extends GetxController {
  static GetSingleUserController get instance => Get.find();

  // User variable
  final Rx<UserModel> user = UserModel.empty().obs;

  final String userId;
  GetSingleUserController(this.userId);

  @override
  void onInit() {
    super.onInit();
    getUser(userId);
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

  // UserModel getUserById(String userId) async {
  //   try {
  //     final userRepository = Get.put(UserRepository());
  //     final user = await userRepository.fetchUser(userId);

  //     return user;
  //   } catch (e) {
  //     throw e;
  //   }
  // }
}
