import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hometory/dto/containers.dart';
import 'package:hometory/services/data_services.dart';
import 'package:meta/meta.dart';

part 'containers_state.dart';

class ContainersCubit extends Cubit<ContainersState> {
  ContainersCubit() : super(ContainersInitial());

  Future<void> fetchContainersCubit() async {
    try {
      debugPrint("nice job!!!");
      List<Containers>? tempContainers;
      tempContainers = await DataService.fetchContainers();
      debugPrint("${tempContainers.length}");
      // emit(ContainersState(ListOfContainers: tempRuangan));
      emit(ContainersState(ListOfContainers: tempContainers));
    } catch (e) {
      debugPrint("eror fetching data containers");
    }
  }
}
