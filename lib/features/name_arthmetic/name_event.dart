import 'package:arithmetic_app/common/bases/base_event.dart';

class ClickNameBtnEvent extends BaseEvent{
  String? firstName;
  String? middleName;
  String? lastName;

  ClickNameBtnEvent(this.firstName, this.middleName, this.lastName);

  @override
  // TODO: implement props
  List<Object?> get props => [];

}