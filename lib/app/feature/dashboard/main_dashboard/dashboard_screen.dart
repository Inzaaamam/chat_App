import 'package:chat_app/app/sdk/extension/padding_exten.dart';
import 'package:chat_app/app/sdk/style/color/color.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 130,
          backgroundColor: AppColor.primaryColor,
          title: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 55,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: AppColor.textColor, borderRadius: BorderRadius.circular(30)),
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                      hintText: "Email",
                      filled: false,
                      fillColor: AppColor.textColor,
                      border: InputBorder.none,
                      prefixIcon:
                          const Icon(Icons.info, size: 40, color: AppColor.primaryColor),
                      // Email icon
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 30,
                        ), // Suffix icon
                        onPressed: () {},
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                  ),
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Chats',
                    style: TextStyle(color: AppColor.textColor, fontSize: 20),
                  ),
                  Text(
                    'Calls',
                    style: TextStyle(color: AppColor.textColor, fontSize: 20),
                  ),
                ],
              ).padOnly(left: 60, right: 60, top: 20, bottom: 20)
            ],
          ),
        ),
      ),
    );
  }
}
