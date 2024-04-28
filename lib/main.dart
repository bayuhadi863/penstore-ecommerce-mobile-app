import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:penstore/firebase_options.dart';
import 'package:penstore/screens/auth/login_screen.dart';
import 'package:penstore/screens/auth/register_screen.dart';
import 'package:penstore/screens/bottom_navigation.dart';
import 'package:penstore/screens/cart/cart_screen.dart';
import 'package:penstore/screens/cart/order_screen.dart';
import 'package:penstore/screens/chat/chat_detail_screen.dart';
import 'package:penstore/screens/product/detail_product_screen.dart';

Future<void> main() async {
  // Widget initialization
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Firebase initialization
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //     .then(
  //   (FirebaseApp value) => Get.put(AuthRepository()),
  // );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(
            name: '/',
            page: () => FirebaseAuth.instance.currentUser != null
                ? const MyBottomNavBar()
                : const LoginScreen()),
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/register', page: () => const RegisterScreen()),
        GetPage(name: '/detail-product', page: () => const DetailProductScreen()),
        GetPage(name: '/cart', page: () => const CartScreen()),
        GetPage(name: '/detail-chat', page: () => const ChatDetailScreen()),
        GetPage(name: '/checkout', page: () => const CheckoutScreen()),
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      debugShowCheckedModeBanner: false,
      title: 'PENSTORE',
      // home: LoginScreen(),
    );
  }
}
