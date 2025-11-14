import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:books/core/di/service_locator.dart';
import 'package:books/core/resoures/app_images.dart';
import 'package:books/features/Auth/manager/auth_cubit.dart';
import 'package:books/features/Auth/precentation/view/register_view.dart';
import 'package:books/features/home/presentation/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/show_snack.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_from_field.dart';
import '../../data/auth_repo.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(getIt.get<AuthRepo>()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(22.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 35),

                      // EMAIL
                      CustomTextFormField(
                        hintText: "Email",
                        isPassword: false,
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: const Icon(Icons.email, color: Colors.black),
                      ),

                      const SizedBox(height: 20),

                      // PASSWORD
                      CustomTextFormField(
                        hintText: "Password",
                        isPassword: true,
                        controller: passwordController,
                        prefixIcon: const Icon(Icons.lock, color: Colors.black),
                      ),

                      const SizedBox(height: 30),

                      // LISTENER ONLY
                      BlocListener<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if (state is AuthLoadingState) {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (_) =>
                              const Center(child: CircularProgressIndicator()),
                            );
                          }

                          if (state is AuthSuccessState) {
                            Navigator.pop(context);

                            showSnack(
                              context: context,
                              title: "Login Successfully",
                              message: "Welcome",
                              type: ContentType.success,
                            );

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeView(),
                              ),
                            );
                          }

                          if (state is AuthErrorState) {
                            Navigator.pop(context);

                            showSnack(
                              context: context,
                              title: "Login Failed",
                              message: state.message,
                              type: ContentType.failure,
                            );
                          }
                        },
                        child: const SizedBox.shrink(),
                      ),

                      // LOGIN BUTTON
                      CustomButton(
                        text: "Login",
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            context.read<AuthCubit>().login(
                              emailController.text.trim(),
                              passwordController.text.trim(),
                            );
                          }
                        },
                      ),

                      const SizedBox(height: 20),

                      // SIGN IN WITH GOOGLE
                      GestureDetector(
                        onTap: () {
                          context.read<AuthCubit>().loginWithGoogle();
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppImages.googleImage,
                                width: 24,
                                height: 24,
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                'Sign in with Google',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // GO TO REGISTER
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterView(),
                            ),
                          );
                        },
                        child: const Text(
                          "Don't have an account? Register",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
