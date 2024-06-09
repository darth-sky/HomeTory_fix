part of 'containers_cubit.dart';

@immutable
class ContainersState {
  const ContainersState({required this.ListOfContainers});
  final List<Containers> ListOfContainers;
}

final class ContainersInitial extends ContainersState {
  ContainersInitial()
      : super(ListOfContainers: [
          Containers(
              id_containers: 1,
              id_ruangan: 1,
              nama_containers: 'default',
              gambar_containers: 'pfp.jpg')
        ]);
}
