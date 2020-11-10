part of 'editavt_bloc.dart';

abstract class EditavtEvent extends Equatable {
  const EditavtEvent();

  @override
  List<Object> get props => [];
}

class EditavtClickEvent extends EditavtEvent {
  File imageFile;
  EditavtClickEvent({this.imageFile});
}
