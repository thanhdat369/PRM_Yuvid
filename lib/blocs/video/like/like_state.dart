part of 'like_bloc.dart';

abstract class LikeState extends Equatable {
  const LikeState();

  @override
  List<Object> get props => [];
}

class LikeInitial extends LikeState {}

class LikeLoadingState extends LikeState {}

class LikeSuccessState extends LikeState {}

class LikeFailedState extends LikeState {}
