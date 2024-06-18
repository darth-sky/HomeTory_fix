import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthInitialState());

  void login(String accessToken, int idUser, String roles) {
    emit(AuthState(
        isLoggedIn: true,
        accessToken: accessToken,
        idPengguna: idUser,
        roles: roles));
  }

  void logout() {
    emit(const AuthState(
        isLoggedIn: false, accessToken: "", idPengguna: 1, roles: "biasa"));
  }

  void becomePro(int id_pengguna) {
    emit( AuthState(isLoggedIn: true, accessToken: '', idPengguna: id_pengguna, roles: 'pro'));
  }
}
