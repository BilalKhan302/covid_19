import 'dart:convert';

import 'package:covid_19/Services/Utilities/AppUrl.dart';
import 'package:http/http.dart'as http;
import '../Model/WorldStatesModel.dart';
class StatesServices{
  Future<WorldStatesModel> fetchWorldStatesRecord()async{
    final response=await http.get(Uri.parse(AppUrl.worldStatesApi));
    if(response.statusCode==200){
      var data=jsonDecode(response.body.toString());
      return WorldStatesModel.fromJson(data);
    }else{
      throw Exception("Error");
    }
    
  }
  Future<List<dynamic>> countriesListApi()async{
    final response=await http.get(Uri.parse(AppUrl.countriesList));
    var data;
    if(response.statusCode==200){
      data=jsonDecode(response.body.toString());
      return data;
    }else{
      throw Exception("Error");
    }

  }
}