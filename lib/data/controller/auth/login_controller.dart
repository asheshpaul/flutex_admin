import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutex_admin/core/helper/shared_preference_helper.dart';
import 'package:flutex_admin/core/route/route.dart';
import 'package:flutex_admin/data/model/auth/login/login_response_model.dart';
import 'package:flutex_admin/data/model/global/response_model/response_model.dart';
import 'package:flutex_admin/data/repo/auth/login_repo.dart';
import 'package:flutex_admin/view/components/snack_bar/show_custom_snackbar.dart';

class LoginController extends GetxController {
  LoginRepo loginRepo;

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  TextEditingController emailController =
      TextEditingController(text: 'ashesh@email.com');
  TextEditingController passwordController =
      TextEditingController(text: '12345678');

  List<String> errors = [];
  String? email;
  String? password;
  bool remember = false;

  LoginController({required this.loginRepo});

  Future<void> checkAndGotoNextStep(LoginResponseModel responseModel) async {
    if (remember) {
      await loginRepo.apiClient.sharedPreferences
          .setBool(SharedPreferenceHelper.rememberMeKey, true);
    } else {
      await loginRepo.apiClient.sharedPreferences
          .setBool(SharedPreferenceHelper.rememberMeKey, false);
    }

    await loginRepo.apiClient.sharedPreferences.setString(
        SharedPreferenceHelper.userIdKey,
        responseModel.data?.staff!.staffId.toString() ?? '-1');
    await loginRepo.apiClient.sharedPreferences.setString(
        SharedPreferenceHelper.accessTokenKey,
        responseModel.data?.accessToken.toString() ?? '');
    await loginRepo.apiClient.sharedPreferences.setString(
        SharedPreferenceHelper.accessSessionKey,
        responseModel.data?.session.toString() ?? '');

    Get.offAndToNamed(RouteHelper.dashboardScreen);

    if (remember) {
      changeRememberMe();
    }
  }

  bool isSubmitLoading = false;

  void loginUser() async {
    isSubmitLoading = true;
    update();

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Assuming you have a method to handle successful login
      handleSuccessfulLogin(userCredential.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        CustomSnackBar.error(errorList: ['No user found for that email.']);
      } else if (e.code == 'wrong-password') {
        CustomSnackBar.error(errorList: ['Wrong password provided.']);
      } else {
        CustomSnackBar.error(errorList: [e.message ?? 'An error occurred.']);
      }
    } catch (e) {
      CustomSnackBar.error(errorList: [e.toString()]);
    }

    isSubmitLoading = false;
    update();
  }

  void handleSuccessfulLogin(User? user) {
    if (user != null) {
      CustomSnackBar.success(successList: ['Login successfully']);
      // Navigate to the next screen or perform other actions
      Get.offAndToNamed(RouteHelper.dashboardScreen);
    }
  }

  // void loginUser() async {
  //   isSubmitLoading = true;
  //   update();
  //
  //   ResponseModel model = await loginRepo.loginUser(
  //       emailController.text.toString(), passwordController.text.toString());
  //
  //   if (model.statusCode == 200) {
  //     LoginResponseModel loginModel =
  //         LoginResponseModel.fromJson(jsonDecode(model.responseJson));
  //     if (loginModel.status!) {
  //       checkAndGotoNextStep(loginModel);
  //     } else {
  //       CustomSnackBar.error(errorList: [loginModel.message!]);
  //     }
  //   } else {
  //     CustomSnackBar.error(errorList: [model.message.tr]);
  //   }
  //   isSubmitLoading = false;
  //   update();
  // }

  changeRememberMe() {
    remember = !remember;
    update();
  }

  void clearTextField() {
    passwordController.text = '';
    emailController.text = '';
    if (remember) {
      remember = false;
    }
    update();
  }
}
