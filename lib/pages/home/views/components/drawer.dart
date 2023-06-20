import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app_talatix/config/config.dart';
import 'package:test_app_talatix/pages/home/controllers/controller.dart';
import 'package:test_app_talatix/widgets/dash_line.dart';

class CustomDrawer extends GetView<HomeController> {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Config.primaryColor,
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "test_app".tr,
                      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15.0),
                    Text(
                      "test_app_sub_text".tr,
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const DashLine(dashColor: Colors.white),
                      Obx(
                        () => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: Config.languages
                                .map(
                                  (e) => GestureDetector(
                                    onTap: () {
                                      if (controller.storage.lang.data?.value != e.langValue) {
                                        controller.storage.changeLanguage(e.langValue);
                                      }
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: controller.storage.lang.data?.value == e.langValue ? Colors.white : Config.primaryColor,
                                        border: Border.all(color: Colors.white),
                                        borderRadius: BorderRadius.circular(Config.borderRadius),
                                      ),
                                      child: Center(
                                        child: Text(
                                          e.shortLabel,
                                          style: TextStyle(
                                              color: controller.storage.lang.data?.value == e.langValue ? Config.primaryColor : Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                      const DashLine(dashColor: Colors.white),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
