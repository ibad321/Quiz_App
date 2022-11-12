import 'dart:convert';

import 'package:http/http.dart' as http;
var link="https://opentdb.com/api.php?amount=20";

 getApi()async {
  var Responce= await http.get(Uri.parse(link));
  if(Responce.statusCode==200){
    var data=jsonDecode(Responce.body);
    print("Data is loaded");
    return data;
  }

}