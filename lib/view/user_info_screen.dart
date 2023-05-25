
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
import '../controller/user_info_screen_controller.dart';

class UserInfoScreen extends StatelessWidget {

  final userInfoScreenController = Get.put(UserInfoScreenController());

  @override
  Widget build(BuildContext context)  {

    return Scaffold(

      appBar: AppBar(title: const Text('Random User Info'),),
        body:Obx(() => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //TODO: data not found
            if(userInfoScreenController.screenDisplayDataStatus.value==0)...{
              Center(child:Text("${userInfoScreenController.screenMessage}", style: ThemeData().textTheme.labelLarge),),
            }
            //TODO: loaded data shown
            else if(userInfoScreenController.screenDisplayDataStatus.value==1)...{
              Expanded(
                child:Center(child: Container(
                  color: Colors.grey,
                  height: 300,
                  width: 300,
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() => Image.network(
                        // TODO: use avatar field from json
                        '${userInfoScreenController.imageLink}',

                        // "https://placehold.co/200x200.png",
                        width: 150,
                        height: 150,
                        errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error),
                      )),
                      const SizedBox(height: 40),
                      // TODO: use first_name & last_name fields from json
                      Obx(() => Text(" ${userInfoScreenController.userFirstName} ${userInfoScreenController.userLastName}", style: ThemeData().textTheme.labelLarge)),
                      // TODO: phone_number
                      Obx(() => Text(" ${userInfoScreenController.userPhoneNo} ", style: ThemeData().textTheme.labelLarge)),
                      // TODO: format date_of_birth properly
                      // Obx(() => Text(" Jan 24, 1990", style: ThemeData().textTheme.labelLarge)),
                      Obx(() => Text(" ${userInfoScreenController.userDateOfBirth}", style: ThemeData().textTheme.labelLarge)),
                    ],
                  ),
                )),
              )

            }
            //TODO: data loading
            else...{
                const Center(
                  child: SizedBox(
                    height: 120,
                    width: 120,
                    child: RiveAnimation.asset('assets/loading_new.riv'),
                  ),
                )

              }
          ],
        )),


      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: () {
          // TODO: trigger fetch random data from api
          userInfoScreenController.getRandomUserData();
        },
      ),
    );
  }




}