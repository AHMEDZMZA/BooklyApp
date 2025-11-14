import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/helpers/show_snack.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_from_field.dart';
import '../../data/auth_repo.dart';
import '../../manager/auth_cubit.dart';
import 'login_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(getIt.get<AuthRepo>()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Register",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 35),

                          // Email
                          CustomTextFormField(
                            hintText: "Email",
                            isPassword: false,
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: const Icon(
                              Icons.email,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Password
                          CustomTextFormField(
                            hintText: "Password",
                            isPassword: true,
                            controller: passwordController,
                            prefixIcon: const Icon(Icons.lock, color: Colors.black),
                          ),
                          const SizedBox(height: 20),

                          // Confirm Password
                          CustomTextFormField(
                            hintText: "Confirm Password",
                            isPassword: true,
                            controller: confirmPasswordController,
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 30),

                          // BlocListener for side effects
                          BlocListener<AuthCubit, AuthState>(
                            listener: (context, state) {
                              if (state is AuthLoadingState) {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (_) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }

                              if (state is AuthSuccessState) {
                                Navigator.pop(context); // Close loading
                                showSnack(
                                  context: context,
                                  title: "Success",
                                  message: "Account created successfully",
                                  type: ContentType.success,
                                );

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const LoginView(),
                                  ),
                                );
                              }

                              if (state is AuthErrorState) {
                                Navigator.pop(context); // Close loading
                                showSnack(
                                  context: context,
                                  title: "Registration Failed",
                                  message: state.message,
                                  type: ContentType.failure,
                                );
                              }
                            },
                            child: const SizedBox.shrink(),
                          ),

                          // Register Button (UI)
                          CustomButton(
                            text: "Register",
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                if (passwordController.text.trim() !=
                                    confirmPasswordController.text.trim()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Passwords do not match"),
                                    ),
                                  );
                                  return;
                                }
                                context.read<AuthCubit>().register(
                                  emailController.text.trim(),
                                  passwordController.text.trim(),
                                );
                              }
                            },
                          ),

                          const SizedBox(height: 20),

                          // Go back to Login
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Already have an account? Login",
                              style: TextStyle(color: Colors.white70),
                            ),
                          ),
                        ],
                      ),
                    ),
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
