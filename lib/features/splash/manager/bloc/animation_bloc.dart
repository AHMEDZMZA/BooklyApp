import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'animation_event.dart';

part 'animation_state.dart';

class AnimationBloc extends Bloc<AnimationEvent, AnimationState> {
  AnimationBloc() : super(AnimationInitial()) {
    late AnimationController animationController;
    late Animation<Offset> imageAnimation;
    late Animation<Offset> textAnimation;

    on<ParameterAnimationEvent>((event, emit) {
      try {
        animationController = AnimationController(
          vsync: event.vsync,
          duration: const Duration(seconds: 5),
        );
        imageAnimation = Tween<Offset>(
          begin: const Offset(0, -10),
          end: const Offset(0, 0),
        ).animate(animationController);

        textAnimation = Tween<Offset>(
          begin: const Offset(0, 10),
          end: const Offset(0, 0),
        ).animate(animationController);

        animationController.forward();
        emit(AnimationSuccess(imageAnimation, textAnimation));
      } catch (e) {
        emit(AnimationError(e.toString()));
      }
    });
  }
}
