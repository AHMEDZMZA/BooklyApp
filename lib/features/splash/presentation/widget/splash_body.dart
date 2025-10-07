import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/resoures/app_images.dart';
import '../../../../core/resoures/app_styels.dart';
import '../bloc/animation_bloc.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> with TickerProviderStateMixin {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 6), () {
      Navigator.pushReplacementNamed(context, '/HomeView');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      /// Call Function
      // create: (context) => AnimationBloc()..animate(this), ]
      /// Call Event
      create: (context) => AnimationBloc()..add(ParameterAnimationEvent(this)),
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
                  const SizedBox(height: 15),
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
