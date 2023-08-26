part of 'snackbar_bloc_bloc.dart';

abstract class SnackbarBlocEvent extends Equatable {
  const SnackbarBlocEvent();

  @override
  List<Object> get props => [];
}

class statusTrue extends SnackbarBlocEvent {}

class statusFalse extends SnackbarBlocEvent {}
