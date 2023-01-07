import 'dart:async';

import 'package:arithmetic_app/data/datasources/remote/api_request.dart';
import 'package:arithmetic_app/data/datasources/remote/dto/number_dto.dart';
import 'package:flutter/services.dart';
import '../datasources/remote/dto/app_resource.dart';
import 'dart:io';
import 'dart:convert';
class DateRepository{
  late ApiRequest _apiRequest;
  void updateApiRequest(ApiRequest apiRequest){
    _apiRequest = apiRequest;
  }

  Future<AppResource<Number_DTO>> getDataMainNumberById(int id) async{
    Completer<AppResource<Number_DTO>> completer = Completer();
    try{
      String jsonString = await rootBundle.loadString("assets/number_mock/2.json");
      print("jsonString = ${jsonString}");
      Map<String, dynamic> jsonData = jsonDecode(jsonString);
      print("decode done");
      AppResource<Number_DTO> resourceDTO = AppResource.fromJson(jsonData, Number_DTO.fromJson);
    }catch(e){
      print("getDataMainNumberById error : ${e.toString()}");
    }
    return completer.future;
  }
}