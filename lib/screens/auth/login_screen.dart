import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/auth/login_controller.dart';
import 'package:penstore/screens/auth/register_screen.dart';
import 'package:penstore/screens/bottom_navigation.dart';
import 'package:penstore/utils/auth_validations.dart';
// import 'package:penstore/screens/home_screen.dart';
import 'package:penstore/widgets/text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _isObscure = true;

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;

    final loginController = Get.put(LoginController());

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: mediaQueryHeight,
          width: mediaQueryWidth,
          child: Stack(
            children: [
              // gambar
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: mediaQueryHeight * 0.380,
                  width: mediaQueryWidth,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/prabowo.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              // form login
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: mediaQueryHeight * 0.657,
                  width: mediaQueryWidth,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 30),
                        child: Form(
                          key: loginController.formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Selamat Datang',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                'Isilah identitas anda dibawah ini untuk masuk',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 20),
                              CustomTextField(
                                controller: loginController.email,
                                validator: (value) =>
                                    AuthValidations.validateEmail(value),
                                focusNode: _emailFocusNode,
                                hintText: 'Email',
                                prefixIcon: 'email',
                                keyboardType: TextInputType.emailAddress,
                                onSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_passwordFocusNode);
                                },
                              ),
                              const SizedBox(height: 20),
                              CustomTextField(
                                keyboardType: TextInputType.visiblePassword,
                                controller: loginController.password,
                                validator: (value) =>
                                    AuthValidations.validateEmptyText(
                                        'Password', value),
                                focusNode: _passwordFocusNode,
                                hintText: 'Password',
                                prefixIcon: 'lock',
                                obscureText: _isObscure,
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  },
                                  child: Icon(
                                    _isObscure
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: _isObscure
                                        ? const Color(0xFF757B7B)
                                        : const Color(0xFF6BCCC9),
                                  ),
                                ),
                                onSubmitted: (_) {
                                  //fungsi untuk menampilkan password
                                  _passwordFocusNode.unfocus();
                                },
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF6BCCC9),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(27),
                                  ),
                                  shadowColor:
                                      const Color(0xFF91E0DD).withOpacity(0.3),
                                  visualDensity: VisualDensity.standard,
                                  elevation: 4,
                                  minimumSize: const Size(double.infinity, 54),
                                ),
                                onPressed: () {
                                  loginController.login(context);
                                },
                                child: const Text(
                                  'Masuk',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Belum punya akun? ',
                                style: TextStyle(
                                  color: Color(0xFF757B7B),
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed("/register");
                                },
                                child: const Text(
                                  'Daftar Sekarang!',
                                  style: TextStyle(
                                    color: Color(0xFF6BCCC9),
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
