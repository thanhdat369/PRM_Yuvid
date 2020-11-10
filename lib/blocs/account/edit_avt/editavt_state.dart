part of 'editavt_bloc.dart';

abstract class EditavtState extends Equatable {
  const EditavtState();

  @override
  List<Object> get props => [];
}

class EditavtInitial extends EditavtState {}

class EditavtSuccessState extends EditavtState {}

class EditavtFailedState extends EditavtState {}

class EditavtLoadingState extends EditavtState {}
