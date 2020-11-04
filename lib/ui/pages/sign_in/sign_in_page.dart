import 'package:chat_flutter/config/app_radius.dart';
import 'package:chat_flutter/config/app_space.dart';
import 'package:chat_flutter/services/auth/authenticator.dart';
import 'package:chat_flutter/ui/atoms/error_dialog.dart';
import 'package:chat_flutter/ui/atoms/input_text_field.dart';
import 'package:chat_flutter/ui/pages/profile/profile_controller.dart';
import 'package:chat_flutter/ui/pages/sign_in/sign_in_controller.dart';
import 'package:flutter/material.dart';

import 'package:chat_flutter/config/app_text_size.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  const SignInPage._();

  static Widget wrapped(Authenticator authenticator) {
    return ChangeNotifierProvider<SignInController>(
      create: (_) => SignInController(authenticator),
      child: const SignInPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SignInController>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
              left: AppSpace.midium,
              top: AppSpace.big,
            ),
            child: const Text(
              'SIGN IN',
              style: TextStyle(
                fontSize: AppTextSize.big,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: AppSpace.big,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(
                left: AppSpace.midium,
                top: AppSpace.xlarge,
                right: AppSpace.midium,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppRadius.large),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      InputTextField(
                        hintText: 'email',
                        keyboardType: TextInputType.text,
                        controller: controller.emailTextController,
                      ),
                      InputTextField(
                        hintText: 'password',
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        controller: controller.passwordTextController,
                      ),
                      const SizedBox(
                        height: AppSpace.big,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: AppSpace.large,
                  ),
                  RaisedButton(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpace.big,
                      vertical: AppSpace.small,
                    ),
                    child: const Text(
                      'Start',
                      style: TextStyle(
                        fontSize: AppTextSize.xlarge,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    color: Colors.white,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        style: BorderStyle.solid,
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(AppRadius.xlarge),
                    ),
                    onPressed: () async {
                      if (controller.email == null ||
                          controller.password == null) {
                        const String message =
                            'Emails and passwords should not be empty.';
                        await showDialog<void>(
                            context: context,
                            builder: (context) => const ErrorDialog(message));
                      } else {
                        try {
                          await controller.signIn();
                          await Provider.of<ProfileController>(context,
                                  listen: false)
                              .getUserById();
                          await Navigator.pushNamed(context, '/homePage');
                        } on Exception catch (e) {
                          await showDialog<void>(
                              context: context,
                              builder: (context) => ErrorDialog(e.toString()));
                        }
                      }
                    },
                  ),
                  const SizedBox(
                    height: AppSpace.large,
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signUpPage');
                    },
                    child: const Text(
                      'SIGN UP',
                      style: TextStyle(
                        fontSize: AppTextSize.large,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
