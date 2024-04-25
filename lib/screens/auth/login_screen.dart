import 'package:flutter/material.dart';
import 'package:penstore/screens/auth/register_screen.dart';
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

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: mediaQueryHeight,
          width: mediaQueryWidth,
          child: Stack(
            children: [
              // gambar
              Container(
                height: mediaQueryHeight * 0.437,
                width: mediaQueryWidth,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/prabowo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // form login
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: mediaQueryHeight * 0.6,
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
                              // controller: TextEditingController(),
                              focusNode: _emailFocusNode,
                              hintText: 'Email',
                              prefixIcon: Icons.email,
                              keyboardType: TextInputType.emailAddress,
                              onSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_passwordFocusNode);
                              },
                            ),
                            const SizedBox(height: 20),
                            CustomTextField(
                              keyboardType: TextInputType.visiblePassword,
                              // controller: TextEditingController(),
                              focusNode: _passwordFocusNode,
                              hintText: 'Password',
                              prefixIcon: Icons.lock,
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
                                  color: const Color(0xFF757B7B),
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
                              onPressed: () {},
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const RegisterScreen(),
                                    ),
                                  );
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
