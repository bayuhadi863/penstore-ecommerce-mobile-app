import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penstore/controller/auth/register_controller.dart';
import 'package:penstore/screens/auth/verification_screen.dart';
import 'package:penstore/utils/auth_validations.dart';
import 'package:penstore/widgets/text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  bool _isObscure = true;

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _nameFocusNode.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;

    final registerController = Get.put(RegisterController());

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
              // form register
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 30, top: 30, right: 30, bottom: 10),
                        child: Form(
                          key: registerController.formKeyRegister,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Buat Akun Baru',
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
                                controller: registerController.name,
                                validator: (value) =>
                                    AuthValidations.validateName(value),
                                keyboardType: TextInputType.text,
                                focusNode: _nameFocusNode,
                                hintText: 'Nama Lengkap',
                                prefixIcon: 'user_outline',
                                onSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_emailFocusNode);
                                },
                              ),
                              const SizedBox(height: 16),
                              CustomTextField(
                                controller: registerController.email,
                                validator: (value) =>
                                    AuthValidations.validateEmail(value),
                                focusNode: _emailFocusNode,
                                hintText: 'Email',
                                prefixIcon: 'email',
                                keyboardType: TextInputType.emailAddress,
                                onSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_phoneFocusNode);
                                },
                              ),
                              // SizedBox(
                              //   height: 2,
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 16),
                              //   child: Text(
                              //     'Email tidak valid',
                              //     style: TextStyle(fontSize: 12),
                              //   ),
                              // ),
                              // const SizedBox(height: 16),
                              // CustomTextField(
                              //   controller: registerController.phone,
                              //   validator: (value) =>
                              //       AuthValidations.validatePhone(value),
                              //   focusNode: _phoneFocusNode,
                              //   hintText: 'No Telepon',
                              //   prefixIcon: 'phone',
                              //   keyboardType: TextInputType.phone,
                              //   onSubmitted: (_) {
                              //     FocusScope.of(context)
                              //         .requestFocus(_passwordFocusNode);
                              //   },
                              // ),
                              const SizedBox(height: 16),
                              CustomTextField(
                                keyboardType: TextInputType.visiblePassword,
                                controller: registerController.password,
                                validator: (value) =>
                                    AuthValidations.validatePassword(value),
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
                                  registerController.register(context);
                                  // Get.to(
                                  //   VerificationScreen(email: registerController.email.text),
                                  // );
                                },
                                child: const Text(
                                  'Daftar',
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
                                'Sudah punya akun? ',
                                style: TextStyle(
                                  color: Color(0xFF757B7B),
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: const Text(
                                  'Masuk Sekarang!',
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
