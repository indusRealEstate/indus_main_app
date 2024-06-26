import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInPageController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode focusNodeMail = FocusNode();
  FocusNode focusNodePass = FocusNode();

  RxBool hidePassword = true.obs;

  RxBool agreeTerms = false.obs;

  @override
  void onInit() async {
    super.onInit();
  }
}
