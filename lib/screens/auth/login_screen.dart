import 'package:flick_admin_panel/screens/auth/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/loading_provider.dart';
import '../../services/auth_services.dart';
import '../../theme/text_style.dart';
import '../../utils/navigation.dart';
import '../../widget/primary_button.dart';
import '../../widget/text_inputs.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                Center(
                  child: SizedBox(
                    height: 150,
                    width: 250,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ),
                const SizedBox(height: 20),
                Text("E-mail", style: AppTextStyles.signUpTextStyle),
                const SizedBox(height: 10),
                AuthTextInput(controller: emailController, hintText: 'Email'),
                const SizedBox(height: 20),
                Text("Password", style: AppTextStyles.signUpTextStyle),
                const SizedBox(height: 10),
                AuthTextInput(controller: passwordController, hintText: 'Password'),
                const SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text("Forgot Password?", style: AppTextStyles.heading1),
                ),
                const SizedBox(height: 30),
                Consumer<LoadingProvider>(
                  builder: (context, loadingController, child) {
                    return loadingController.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : PrimaryButton(
                            onTap: () async {
                              await AuthServices().signIn(
                                context: context,
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            },
                            title: "Register",
                          );
                  },
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () => navigateToPage(context, const SignUpScreen()),
                  child: Center(
                    child: Text("Don't have an Account? SignUp", style: AppTextStyles.signUpTextStyle),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
