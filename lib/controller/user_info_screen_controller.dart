

import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import '../constant/api_url.dart';

class UserInfoScreenController extends GetxController {

  var userFirstName="".obs;
  var userLastName="".obs;
  var userPhoneNo="".obs;
  var userDateOfBirth="".obs;
  var imageLink="".obs;


  // TODO: if value is 0 then the Screen shows no data
  // TODO: else if the value is 1 then the Screen shows user data
  // TODO: else screen shows the loading indicator
  var screenDisplayDataStatus=0.obs;

  var screenMessage="No Data".obs;


  @override
  void onInit() {
    super.onInit();
  //  getUserAddressData();
  }


  // TODO: retrieve random user data from api
  void getRandomUserData() async{
    try {
      screenDisplayDataStatus(2);
      var response = await get(
        Uri.parse(ApiUrl.USER_DATA_URL),
      );

      if (response.statusCode == 200) {

        screenDisplayDataStatus(1);

        var responseData = jsonDecode(response.body);

        try{
          userFirstName(responseData["first_name"].toString());
        } catch(e){}
        try{
          userLastName(responseData["last_name"].toString());
        } catch(e){}
        try{
          userPhoneNo(responseData["phone_number"].toString());
        } catch(e){}
        try{
          userDateOfBirth(dateConvert(responseData["date_of_birth"].toString()));
        } catch(e){}

        try{
          imageLink(responseData["avatar"].toString());
        } catch(e){}

      }
      else {
        screenDisplayDataStatus(2);
        screenMessage("Something wrong!");
      }
    } catch (e) {
      // screenMessage("Something wrong!");
    }
  }


  // TODO: date converter
  String dateConvert(String inputDate) {
    DateTime dateTime = DateTime.parse(inputDate);
    String formattedDate = DateFormat('MMM dd, yyyy').format(dateTime);
    return formattedDate;
  }

}