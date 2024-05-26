import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:penstore/firebase_options.dart';
import 'package:penstore/screens/auth/login_screen.dart';
import 'package:penstore/screens/auth/register_screen.dart';
import 'package:penstore/screens/bottom_navigation.dart';
import 'package:penstore/screens/cart/cart_screen.dart';
import 'package:penstore/screens/cart/order_screen.dart';
import 'package:penstore/screens/chat/chat_detail_screen.dart';
import 'package:penstore/screens/payment/payment_buyer_screen.dart';
import 'package:penstore/screens/payment/payment_seller_screen.dart';
import 'package:penstore/screens/product/detail_product_screen.dart';
import 'package:penstore/screens/wishlist/wishlist_detail_screen.dart';
import 'package:penstore/screens/wishlist/wishlist_screen.dart';
import 'package:penstore/widgets/decoration_input.dart';
import 'package:penstore/screens/splash_screen.dart';
import 'package:penstore/screens/onboarding_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '/splash', page: () => const SplashScreen()),
        GetPage(
            name: '/',
            page: () => FirebaseAuth.instance.currentUser != null
                ? const MyBottomNavBar()
                : const LoginScreen()),
        GetPage(name: '/onboarding', page: () => OnboardingScreen()),
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/register', page: () => const RegisterScreen()),
        GetPage(
            name: '/detail-product', page: () => const DetailProductScreen()),
        GetPage(name: '/cart', page: () => const CartScreen()),
        GetPage(name: '/detail-chat', page: () => const ChatDetailScreen()),
        GetPage(name: '/checkout', page: () => const CheckoutScreen()),
        GetPage(name: '/payment-buyer', page: () => const PaymentBuyerScreen()),
        GetPage(
            name: '/payment-seller', page: () => const PaymentSellerScreen()),
        GetPage(name: '/wishlist', page: () => const WishlistScreen()),
        GetPage(
            name: '/detail-wishlist', page: () => const WishlistDetailScreen()),
        GetPage(name: '/onboarding', page: () => const OnboardingScreen()),
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          hintStyle: const TextStyle(
            color: Color(0xFF757B7B),
            fontSize: 12,
            fontFamily: 'poppins',
            fontWeight: FontWeight.w400,
          ),
          filled: true,
          fillColor: Colors.white,
          focusColor: const Color(0xFF6BCCC9),
          errorBorder: DecoratedInputBorder(
            child: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
                borderSide: BorderSide(
                  color: Colors.red,
                )),
            shadow: BoxShadow(
              color: const Color(0xFF6BCCC9).withOpacity(0.3),
              blurRadius: 16,
              offset: const Offset(1, 1),
            ),
          ),
          errorStyle: const TextStyle(
            color: Colors.red,
            fontSize: 12,
            fontWeight: FontWeight.normal,
            fontFamily: 'Poppins',
          ),
          focusedBorder: DecoratedInputBorder(
            child: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
                borderSide: BorderSide(
                  color: Color(0xFF6BCCC9),
                )),
            shadow: BoxShadow(
              color: const Color(0xFF6BCCC9).withOpacity(0.3),
              blurRadius: 16,
              offset: const Offset(1, 1),
            ),
          ),
          border: DecoratedInputBorder(
            child: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
              borderSide: BorderSide.none,
            ),
            shadow: BoxShadow(
              color: const Color(0xFF6BCCC9).withOpacity(0.3),
              blurRadius: 16,
              offset: const Offset(1, 1),
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'PENSTORE',
    );
  }
}
