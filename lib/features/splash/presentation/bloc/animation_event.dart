part of 'animation_bloc.dart';

@immutable
sealed class AnimationEvent {}

final class ParameterAnimationEvent extends AnimationEvent {
  final TickerProviderStateMixin vsync;

  ParameterAnimationEvent(this.vsync);
}
