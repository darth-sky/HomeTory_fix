part of 'ruangan_cubit.dart';

@immutable
class RuanganState {
  const RuanganState({required this.ListOfRuangan});
  final List<Ruangan> ListOfRuangan;
}

final class RuanganInitial extends RuanganState {
  RuanganInitial()
      : super(ListOfRuangan: [
          Ruangan(
              id_ruangan: 1,
              id_pengguna: 1,
              nama_ruangan: 'kamar',
              gambar_ruangan: 'pfp.jpg')
        ]);
}
