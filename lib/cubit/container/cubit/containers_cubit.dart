import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:hometory/dto/containers.dart';
import 'package:hometory/services/data_services.dart';

part 'containers_state.dart';

class ContainersCubit extends Cubit<ContainersState> {
  ContainersCubit() : super(ContainersInitial());

  Future<void> fetchContainersCubit(String accessToken) async {
    try {
      debugPrint("nice job!!!");
      List<Containers>? tempContainers;
      tempContainers = await DataService.fetchContainers(accessToken);
      debugPrint("${tempContainers.length}");
      // emit(ContainersState(ListOfContainers: tempRuangan));
      emit(ContainersState(listOfContainers: tempContainers));
    } catch (e) {
      debugPrint("eror fetching data containers");
    }
  }
}
