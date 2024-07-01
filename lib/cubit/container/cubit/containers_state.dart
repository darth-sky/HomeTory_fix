part of 'containers_cubit.dart';

@immutable
class ContainersState {
  const ContainersState({required this.listOfContainers});
  final List<Containers> listOfContainers;
}

final class ContainersInitial extends ContainersState {
  ContainersInitial()
      : super(listOfContainers: [
          Containers(
              idContainer: 1,
              idRuangan: 1,
              namaContainer: 'default',
              gambarContainer: 'pfp.jpg')
        ]);
}
