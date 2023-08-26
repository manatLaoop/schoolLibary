part of 'snackbar_bloc_bloc.dart';

class SnackbarBlocState extends Equatable {
    SnackbarBlocState({bool? this.status});
  bool? status = false;
  SnackbarBlocState copyWith({required bool Status}) {
    return SnackbarBlocState(status: Status);
  }

  @override
  List<Object> get props => [status!];
 
}
