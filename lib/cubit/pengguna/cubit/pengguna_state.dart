part of 'pengguna_cubit.dart';

@immutable
class PenggunaState {
  const PenggunaState({required this.listOfPengguna});
  final List<Pengguna> listOfPengguna;
}

final class PenggunaInitial extends PenggunaState {
  PenggunaInitial()
      : super(listOfPengguna: [
          Pengguna(
              id_pengguna: 1,
              username: 'Test User',
              role: 'biasa',
              foto_profil: 'pfp.jpg',
              email: 'user@gmail.com',
              longtitude: 0,
              latitude: 0,
              )
        ]);
}
