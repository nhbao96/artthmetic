import 'package:arithmetic_app/common/bases/base_bloc.dart';
import 'package:arithmetic_app/common/bases/base_event.dart';
import 'package:arithmetic_app/data/repositories/home_repository.dart';

class HomeBloc extends BaseBloc{
  late HomeRepository _homeRepository;

  void updateHomeRepository(HomeRepository homeRepository){
    _homeRepository = homeRepository;
  }
  @override
  void dispatch(BaseEvent event) {
    // TODO: implement dispatch
  }

}