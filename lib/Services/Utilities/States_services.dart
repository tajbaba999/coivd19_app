import 'dart:convert';

import 'package:covid19_app/Services/Utilities/app_url.dart';
import 'package:http/http.dart' as http;

import '../../Model/WorldStatesModel.dart';

class StateServices{

  Future<WorldStatesModel> fetchWorledStatesRecords() async{
    final responce = await http.get(Uri.parse(APPUrl.worldStatesApi));

    if(responce.statusCode == 200){
      var data = jsonDecode(responce.body);
      return WorldStatesModel.fromJson(data);
    }
    else{
      throw Exception('Error');
    }
  }


  Future<List<dynamic>> countiesListApi() async{

    var data;
    final responce = await http.get(Uri.parse(APPUrl.countriesList));

    if(responce.statusCode == 200){
       data = jsonDecode(responce.body);
      return data;
    }
    else{
      throw Exception('Error');
    }
  }
}