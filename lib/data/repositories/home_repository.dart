import 'package:arithmetic_app/data/datasources/remote/api_request.dart';

class HomeRepository{
  late ApiRequest _apiRequest;
  void updateApiRequest(ApiRequest apiRequest){
    _apiRequest = apiRequest;
  }
}