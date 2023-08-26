// ignore_for_file: non_constant_identifier_names

part of 'setcode_bloc.dart';

class SetcodeState extends Equatable {
  const SetcodeState({this.Code = 'null'});
  final String Code;

  SetcodeState copywith({String? code}) {
    return SetcodeState(Code: code ?? this.Code);
  }

  @override
  List<Object> get props => [this.Code];
}
