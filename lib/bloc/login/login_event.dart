part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class PhoneChanged extends LoginEvent {
  final String phone;

  PhoneChanged({@required this.phone});

  @override
  List<Object> get props => [phone];

  @override
  String toString()=> 'PhoneChanged {phone: $phone}';
}
