import 'package:arithmetic_app/common/bases/base_event.dart';

class ClickConfirmBtnEvent extends BaseEvent{

  int? day;
  int? month;
  int? year;

  ClickConfirmBtnEvent(this.day, this.month, this.year);

  @override
  // TODO: implement props
  List<Object?> get props => [];

}