import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:books/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/helpers/show_snack.dart';
import '../../../../core/resoures/app_images.dart';
import '../../../../core/resoures/app_styels.dart';
import '../../manager/bloc/animation_bloc.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 6), () {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, Routes.homeView);
      showSnack(
        context,
        "Welcome to Books Library",
        "Enjoy your reading journey!",
        ContentType.success,
      );
    });
  }

  @override
  void dispose() {
    context.read<AnimationBloc>().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              getIt<AnimationBloc>()..add(ParameterAnimationEvent(this)),

      // create: (context) => AnimationBloc()..add(ParameterAnimationEvent(this)),
      child: Center(
        child: BlocBuilder<AnimationBloc, AnimationState>(
          builder: (context, state) {
            if (state is AnimationSuccess) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SlideTransition(
                    position: state.imageAnimation,
                    child: Image.asset(AppImages.logoImage, fit: BoxFit.cover),
                  ),
                  SizedBox(height: 15.h),
                  SlideTransition(
                    position: state.textAnimation,
                    child: Text(
                      "Your book library at the office",
                      style: AppStyles.textStyle22Bold,
                    ),
                  ),
                ],
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
