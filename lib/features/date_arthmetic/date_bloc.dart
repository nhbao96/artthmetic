import 'dart:async';

import 'package:arithmetic_app/common/bases/base_bloc.dart';
import 'package:arithmetic_app/common/bases/base_event.dart';
import 'package:arithmetic_app/common/utils/extension.dart';
import 'package:arithmetic_app/data/repositories/date_repository.dart';
import 'package:arithmetic_app/features/date_arthmetic/date_event.dart';

class DateBloc extends BaseBloc{
  late DateRepository _dateRepository;
  StreamController<int> _streamController = StreamController<int>.broadcast();
  int? _day;
  int? _month;
  int? _year;

  StreamController<int> get streamController => _streamController;

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
    try{
        _day = await event.day;
        _month = await event.month;
        _year = await event.year;

        int sumOfStep1 = sumOfDigits(_day!) + sumOfDigits(_month!) + sumOfDigits(_year!);
        int sumOfStep2 = sumOfDigits(sumOfStep1);

        await _dateRepository.getDataMainNumberById(sumOfStep2);
        _streamController.sink.add(sumOfStep2);
    }catch(e){
      print(e.toString());
    }
  }


}