import 'package:flutter/material.dart';
import '../../widget/splash_body.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SplashBody());
  }
}

/*
الـ vsync معناها "synchronization مع شاشة الجهاز"
“اشتغل متزامن مع الشاشة دي،

بيبدأ الحركة (بـ forward())

بيوقفها (stop())

بيرجعها للخلف (reverse())

يعيدها (repeat())
   late AnimationController animationController;
  // late Animation<Offset> imageAnimation;
  // late Animation<Offset> textAnimation;
  //
  // @override
  // void initState() {
  //   animationController = AnimationController(
  //     vsync: this,
  //     duration: const Duration(seconds: 5),
  //   );
  //
  //   imageAnimation = Tween<Offset>(
  //     begin: const Offset(0, -10),
  //     end: const Offset(0, 0),
  //   ).animate(animationController);
  //
  //   textAnimation = Tween<Offset>(
  //     begin: const Offset(0, 10),
  //     end: const Offset(0, 0),
  //   ).animate(animationController);
  //
  //   animationController.forward();
  //
  //   Future.delayed(Duration(seconds: 6), () {
  //     /// Navigate to the next screen
  //   });
  //   super.initState();
  // }
 */
