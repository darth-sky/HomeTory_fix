part of 'auth_cubit.dart';

@immutable
class AuthState {
  final bool isLoggedIn;
  final String? accessToken;
  final int? idPengguna;
  const AuthState(
      {required this.isLoggedIn, this.accessToken, this.idPengguna});
}

final class AuthInitialState extends AuthState {
  const AuthInitialState()
      : super(isLoggedIn: true, accessToken: "", idPengguna: 1);
}
