import 'package:get/get.dart';

class HomeController extends GetxController{
  var name = ''.obs;
  void setName(String newName){
    name.value =  newName;
  }
}