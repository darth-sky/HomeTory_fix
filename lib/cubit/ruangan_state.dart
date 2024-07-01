part of 'ruangan_cubit.dart';

@immutable
class RuanganState {
  const RuanganState({required this.listOfRuangan});
  final List<Ruangan> listOfRuangan;
}

final class RuanganInitial extends RuanganState {
  RuanganInitial()
      : super(listOfRuangan: [
          Ruangan(
              idRuangan: 1,
              idPengguna: 1,
              namaRuangan: 'kamar',
              gambarRuangan: 'pfp.jpg')
        ]);
}
