import 'dart:async';

import 'package:arithmetic_app/common/bases/base_bloc.dart';
import 'package:arithmetic_app/common/bases/base_event.dart';
import 'package:arithmetic_app/common/utils/extension.dart';
import 'package:arithmetic_app/data/datasources/remote/dto/app_resource.dart';
import 'package:arithmetic_app/data/datasources/remote/dto/number_dto.dart';
import 'package:arithmetic_app/data/repositories/date_repository.dart';
import 'package:arithmetic_app/features/date_arthmetic/date_event.dart';

import '../../data/model/number_model.dart';

class DateBloc extends BaseBloc{
  late DateRepository _dateRepository;
  StreamController<NumberModel> _streamController = StreamController<NumberModel>.broadcast();
  NumberModel? _model;
  int? _day;
  int? _month;
  int? _year;
  
  StreamController<NumberModel> get streamController => _streamController;

  int get day => _day ?? 0;

  set day(int value) {
    _day = value;
  }

  int get month => _month ?? 0;

  set month(int value) {
    _month = value;
  }

  int get year => _year ?? 0;

  set year(int value) {
    _year = value;
  }

  void updateDateRepository(DateRepository dateRepository){
    _dateRepository = dateRepository;
  }
  @override
  void dispatch(BaseEvent event) {
    // TODO: implement dispatch
    switch(event.runtimeType){
      case ClickConfirmBtnEvent:
        handleClickConfirmBtnEvent(event as ClickConfirmBtnEvent);
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

  void handleClickConfirmBtnEvent(ClickConfirmBtnEvent event) async{
    loadingSink.add(true);
    try{
        _day = await event.day;
        _month = await event.month;
        _year = await event.year;

        int sumOfStep1 = sumOfDigits(_day!) + sumOfDigits(_month!) + sumOfDigits(_year!);
        int sumOfStep2 = 224;
        if(sumOfStep1 != 224){
          sumOfStep2 = sumOfDigits(sumOfStep1);
        }
        await _dateRepository.getDataMainNumberById(sumOfStep2);
        AppResource<Number_DTO> resourceDTO = await _dateRepository.getDataMainNumberById(sumOfStep2);
        if(resourceDTO.data == null) return;
        Number_DTO modelDTO = resourceDTO.data!;
        _model = NumberModel(modelDTO.id, modelDTO.title, modelDTO.subTile, modelDTO.content);
        print("--->data content = ${_model?.content.toString()}");
        _streamController.add(_model!);

    }catch(e){
      print(e.toString());
    }
    loadingSink.add(false);
  }
}