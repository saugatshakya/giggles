part of 'login_bloc.dart';

@immutable
class LoginState{
  final bool isPhoneNoValid;
  final bool isOtpVaild;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isPhoneNoValid;
  LoginState({
    @required this.isPhoneNoValid,
    @required this.isOtpVaild,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure});

  factory LoginState.empty() {
    return LoginState(isPhoneNoValid: true,isOtpVaild: true,isSubmitting: false,isFailure: false,isSuccess: false);
  }
  factory LoginState.loading() {
      return LoginState(isPhoneNoValid: true,isOtpVaild: true,isSubmitting: true,isFailure: false,isSuccess: false);
  }
  factory LoginState.failure() {
      return LoginState(isPhoneNoValid: true,isOtpVaild: true,isSubmitting: false,isFailure: true,isSuccess: false);
  }
  factory LoginState.success() {
      return LoginState(isPhoneNoValid: true,isOtpVaild: true,isSubmitting: false,isFailure: false,isSuccess: true);
  }
  LoginState update({
    final bool isPhoneNoValid,
    final bool isOtpVaild
  }){
    return copyWith(
      isPhoneNoValid: isPhoneNoValid,isOtpValid: isOtpVaild,isSubmitting: false,isFailure: false,isSuccess: true
    );
  }
  LoginState copyWith({
    bool isPhoneNoValid,
    bool isOtpValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure
  }){
    return LoginState(
      isPhoneNoValid: isPhoneNoValid ?? this.isPhoneNoValid,
      isOtpVaild: isOtpVaild ?? this.isOtpVaild,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure
    );
  }
}