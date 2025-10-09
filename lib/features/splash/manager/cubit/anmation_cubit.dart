// import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// part 'anmation_state.dart';
//
// class AnimationCubit extends Cubit<AnimationState> {
//   AnimationCubit() : super(AnimationInitial());
//   late AnimationController animationController;
//   late Animation<Offset> imageAnimation;
//   late Animation<Offset> textAnimation;
//
//   void animate(TickerProviderStateMixin vsync) {
//     try {
//       animationController = AnimationController(
//         vsync: vsync,
//         duration: const Duration(seconds: 5),
//       );
//
//       imageAnimation = Tween<Offset>(
//         begin: const Offset(0, -10),
//         end: const Offset(0, 0),
//       ).animate(animationController);
//
//       textAnimation = Tween<Offset>(
//         begin: const Offset(0, 10),
//         end: const Offset(0, 0),
//       ).animate(animationController);
//
//       animationController.forward();
//
//       emit(AnimationSuccess(imageAnimation, textAnimation));
//     } catch (e) {
//       emit(AnimationError(e.toString()));
//     }
//   }
// }
