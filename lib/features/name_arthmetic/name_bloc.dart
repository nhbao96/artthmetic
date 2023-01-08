import 'dart:async';

import 'package:arithmetic_app/common/bases/base_bloc.dart';
import 'package:arithmetic_app/common/bases/base_event.dart';
import 'package:arithmetic_app/common/utils/extension.dart';
import 'package:arithmetic_app/data/datasources/remote/dto/app_resource.dart';
import 'package:arithmetic_app/data/datasources/remote/dto/number_dto.dart';
import 'package:arithmetic_app/features/name_arthmetic/name_event.dart';

import '../../data/model/number_model.dart';
import '../../data/repositories/name_repository.dart';

class NameBloc extends BaseBloc {
  late NameRepository _nameRepository;
  StreamController<NumberModel> _streamController = StreamController<NumberModel>();
  NumberModel? _model;
  void updateNameRepository(NameRepository nameRepository) {
    _nameRepository = nameRepository;
  }

  StreamController<NumberModel> get streamController => _streamController;

  @override
  void dispatch(BaseEvent event) {
    // TODO: implement dispatch
    switch (event.runtimeType) {
      case ClickNameBtnEvent:
        handleClickNameBtnEvent(event as ClickNameBtnEvent);
        break;
      default:
        break;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _streamController.close();
  }

  void handleClickNameBtnEvent(ClickNameBtnEvent event) async {
    print("handleClickNameBtnEvent");
    loadingSink.add(true);
    try {
      int numFirstName = converNameToInt(event.firstName.toString());
      int numMiddleName = 0;
      if(event.middleName.toString().isEmpty == false){
        numMiddleName = converNameToInt(event.middleName.toString());
      }
      int numLastName = converNameToInt(event.lastName.toString());

      int sumStep1 = numFirstName + numMiddleName + numLastName;
      int sumStep2 = 0;
      if(!(sumStep1 == 11  || sumStep1 == 22 || sumStep1 == 33)){
           print("------> trigger here sumStep1 = $sumStep1");
          sumStep2 = sumOfDigits(sumStep1);
      }else{
        sumStep2 = sumStep1;
      }
      AppResource<Number_DTO> resourceDTO = await _nameRepository.getDataMainNumberById(sumStep2);
      if(resourceDTO.data ==null) return;
      Number_DTO number_dto = resourceDTO.data!;
      _model = NumberModel(number_dto.id, number_dto.title, number_dto.subTile, number_dto.content);
      _streamController.sink.add(_model!);
    } catch (e) {
      print(e);
    }
    loadingSink.add(false);
  }
}
