import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthInitialState());

  void login(String accessToken, int idUser, String roles, String username) {
    emit(AuthState(
        isLoggedIn: true,
        accessToken: accessToken,
        idPengguna: idUser,
        roles: roles,
        username: username
        ));
  }

  void logout() {
    emit(const AuthState(
        isLoggedIn: false, accessToken: "", idPengguna: 1, roles: "biasa", username: ""));
  }

  // void becomePro(int id_pengguna) {
  //   emit( AuthState(isLoggedIn: true, accessToken: '', idPengguna: id_pengguna, roles: 'pro', username: ""));
  // }
  void becomePro() {
    emit(state.copyWith(roles: 'pro'));
  }
}

extension AuthStateCopyWith on AuthState {
  AuthState copyWith({bool? isLoggedIn, String? accessToken, int? idPengguna, String? roles, String? username}) {
    return AuthState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      accessToken: accessToken ?? this.accessToken,
      idPengguna: idPengguna ?? this.idPengguna,
      roles: roles ?? this.roles,
      username: username ?? this.username,
    );
  }
}