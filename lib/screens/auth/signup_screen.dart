import 'package:flick_admin_panel/providers/loading_provider.dart';
import 'package:flick_admin_panel/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/text_style.dart';
import '../../utils/navigation.dart';
import '../../widget/primary_button.dart';
import '../../widget/text_inputs.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController usernameController = TextEditingController();
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
              children: [
                const SizedBox(height: 50),
                Center(
                  child: SizedBox(
                    height: 150,
                    width: 240,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ),
                const SizedBox(height: 20),
                Text("Name", style: AppTextStyles.signUpTextStyle),
                const SizedBox(height: 10),
                AuthTextInput(controller: usernameController, hintText: 'Name'),
                const SizedBox(height: 20),
                Text("E-mail", style: AppTextStyles.signUpTextStyle),
                const SizedBox(height: 10),
                AuthTextInput(controller: emailController, hintText: 'Email'),
                const SizedBox(height: 20),
                Text("Password", style: AppTextStyles.signUpTextStyle),
                const SizedBox(height: 10),
                AuthTextInput(controller: passwordController, hintText: 'Password'),
                const SizedBox(height: 30),
                Consumer<LoadingProvider>(
                  builder: (context, loadingController, child) {
                    return loadingController.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : PrimaryButton(
                            onTap: () async {
                              await AuthServices().signUp(
                                context: context,
                                username: usernameController.text,
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
                  onTap: () => navigateToPage(context, const LoginScreen()),
                  child: Center(
                    child: Text("Already Have an Account? Login", style: AppTextStyles.signUpTextStyle),
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
